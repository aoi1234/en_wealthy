class ApplicationController < ActionController::Base
  before_action :authenticate_any!, except: [:top]

  def authenticate_any!
    if user_signed_in?
      true
    else
       authenticate_admin!
    end
  end

end