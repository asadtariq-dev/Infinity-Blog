# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_author!
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def routing_error(_error = 'Routing error', _status = :not_found, _exception = nil)
    render file: 'public/404.html', status: :not_found, layout: false
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end

  private

  def record_not_found
    redirect_to author_profile_path(current_author), alert: 'Record Not Found'
  end
end
