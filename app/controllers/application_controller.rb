# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActionController::Serialization
  include Pundit::Authorization

  # before_action :authenticate_author! ## to allow api request

  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::RoutingError, with: :routing_error
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def cors_preflight_check
    return if request.method == :options

    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end

  private

  def routing_error(_error = 'Routing error', _status = :not_found, _exception = nil)
    flash[:alert] = t('page_not_found')
    if current_author.moderator?
      redirect_to moderator_path
    else
      redirect_to author_profile_path(current_author)
    end
  end

  def record_not_found
    flash[:alert] = t('record_not_found')
    if current_author.moderator?
      redirect_to moderator_path
    else
      redirect_to root_path
    end
  end

  def user_not_authorized
    flash[:alert] = t('not_authorized')
    redirect_to(request.referer || root_path)
  end

  def pundit_user
    current_author
  end
end
