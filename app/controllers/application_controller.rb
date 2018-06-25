class ApplicationController < ActionController::Base

  # To allow first_name and last_name to pass through
  before_action :permit_names, if: :devise_controller?

  protected

  def permit_names
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

end
