class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  
  
  def after_sign_in_path_for(resource)
    posts_path
  end
  
  protected
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :email])
  end
end
