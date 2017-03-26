class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to new_session_path unless current_user
  end

  def authorize_admin
    redirect_to new_session_path unless current_user && current_user.is_admin
  end
end
