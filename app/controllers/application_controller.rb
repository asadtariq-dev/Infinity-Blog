class ApplicationController < ActionController::Base
  before_action :authenticate_author!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def routing_error(_error = 'Routing error', _status = :not_found, _exception = nil)
    render file: 'public/ß404.html', status: :not_found, layout: false
  end
ß
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end
end
