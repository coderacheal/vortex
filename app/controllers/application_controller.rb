class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |user| user.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:name, :email, :password, :current_password)
    end
  end

  def after_sign_in_path_for(resource)
    return unless resource.is_a?(User)

    users_path
  end

  def after_sign_up_path_for(_resource)
    users_path
  end
end
