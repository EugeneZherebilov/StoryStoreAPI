Rails.application.routes.draw do
  # Registration & Authentication
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations:      'users/registrations',
      sessions:           'users/sessions',
      token_validations:  'users/token_validations',
      passwords:          'users/passwords'
  }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # Game & Game messages
      resources :games do
        post 'update_image', to: 'games#update_image'
      end
      resources :groups

      #Search
      get 'search_users', to: 'search#find_users'
      
      #Update user avatar
      post 'update_avatar', to: 'user_settings#update_image'
    end
  end

end
