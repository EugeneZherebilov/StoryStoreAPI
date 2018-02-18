class Api::V1::UserSettingsController < BaseController

  def update_image
    if params.key?(:image)
      current_user.update_image(params)
      render :update_image
    else
      render json: { errors: I18n.t("user_settings.INVALID_PARAMS") }, status: :unprocessable_entity
    end
  end
end
