class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :control_active_user

protected
  def configure_permitted_parameters
    #configuration for customizing Gem Devise with name, firstname, ..... in user table.
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:active, :admin, :name, :firstname, :email, :password, :password_confirmation, :current_password) }
  end

def control_active_user
  #Control if the current user is active in user table
    if user_session != nil && params[:user] != nil
      @control = User.where(:email => params[:user][:email]).first.active
      if @control == false
        redirect_to destroy_user_session_path, methode: :get
      end
    end
  end

end
