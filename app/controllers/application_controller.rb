class ApplicationController < ActionController::Base
  # include CategoriesHelper
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |user| user.permit( :email, :password,) }
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:email, :password, :current_password, )
    end
  end

  def after_sign_in_path_for(resource)
    # Customize the redirect path based on your requirements
    # For example:
    if resource.is_a?(User)
      # Redirect to a specific path for a user
      # user_path(resource)
      root_path
    # else
    #   # Redirect to a different path for other resources
    #   root_path
    end
  end
end
