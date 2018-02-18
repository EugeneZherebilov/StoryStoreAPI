class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include CanCan::ControllerAdditions
  include ActionView::Rendering
  include LocaleHelper

  before_action :set_headers_server_time

  rescue_from CanCan::AccessDenied do
    head(:forbidden)
  end

  protected

  def set_headers_server_time
    response.headers['server-time'] = Time.current.to_i
  end

  private

  def render_to_body(options)
    _render_to_body_with_renderer(options) || super
  end

end
