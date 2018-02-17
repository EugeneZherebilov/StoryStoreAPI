class Users::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController

  def omniauth_success
    if auth_hash[:info][:email].blank?
      render json: { errors: "Your account email is empty. Email can't be blank" },
             status: :unprocessable_entity
    else
      get_resource_from_auth_hash
      create_token_info
      set_token_on_resource
      create_auth_params

      if resource_class.devise_modules.include?(:confirmable)
        # don't send confirmation email!!!
        @resource.skip_confirmation!
      end

      sign_in(:user, @resource, store: false, bypass: false)

      @resource.save!

      yield @resource if block_given?
      image_medium = @resource.return_avatar 'medium'
      image_small = @resource.return_avatar 'small'
      @resource.image = @resource.return_avatar 'large'
      render_data_or_redirect('deliverCredentials', @auth_params.as_json, @resource.as_json.merge(image_medium: image_medium, image_small: image_small))
      #Elastic servise update data
      #User.find_by(id: @resource.id).reindex(:search_data)
    end
  end

  protected

  def get_resource_from_auth_hash
    @resource = resource_class.where(email: auth_hash[:info][:email]).first_or_initialize

    identity = Identity.where(uid: auth_hash['uid'],
                              provider: auth_hash['provider'],
                              registration_platform: request.host).first_or_initialize

    @resource.identities << identity if identity.new_record?
    @resource.uid = identity.uid
    @resource.provider = identity.provider
    if @resource.new_record?
      @oauth_registration = true
      set_random_password
    end
    # sync user info with provider, update/generate auth token
    assign_provider_attrs(@resource, auth_hash)

    # assign any additional (whitelisted) attributes
    extra_params = whitelisted_params
    @resource.assign_attributes(extra_params) if extra_params

    @resource
  end

  def assign_provider_attrs(user, auth_hash)
    user.assign_attributes(
      email:      auth_hash['info']['email']
    )
    if auth_hash[:provider] == 'facebook' && auth_hash[:info][:image][0, 5] == 'http:'
      user.assign_attributes(image: 'https:' + auth_hash[:info][:image].from(5)) unless user.image
      user.assign_attributes(name: "#{auth_hash[:info][:first_name]} #{auth_hash[:info][:last_name]}") unless user.name
    else
      user.assign_attributes(image: auth_hash[:info][:image]) unless user.image
      user.assign_attributes(name: "#{auth_hash[:info][:first_name]} #{auth_hash[:info][:last_name]}") unless user.name
    end
  end
end