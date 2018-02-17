class BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!

  def authenticate_user!
    unless current_user
      return render json: {
          error_token: true,
          errors: [I18n.t("devise.failure.unauthenticated")]
      }, status: 401
    end
  end

end