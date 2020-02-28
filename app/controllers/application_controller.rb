class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      user_attrs = [ :email, :name, :password, :password_confirmation ]
      devise_parameter_sanitizer.permit :sign_up, keys: user_attrs
      devise_parameter_sanitizer.permit :account_update, keys: user_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: user_attrs
    end
end
