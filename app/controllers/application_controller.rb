# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_author!

  before_action :configure_permitted_parameters, if: :devise_controller?
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def routing_error(_error = 'Routing error', _status = :not_found, _exception = nil)
    redirect_to author_profile_path(current_author), alert: 'Page Not Found'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end

  private

  # def record_not_found
  #   # binding.pry

  #   redirect_to author_profile_path(current_author), alert: 'Record Not Found'
  # end

  def user_not_authorized
    flash[:alert] = 'Your are not authorized for this action'
    redirect_to(request.referrer || root_path)
  end

  def pundit_user
    current_author
  end
end
