class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :require_login

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session&.user
  end

  def require_login
    redirect_to login_url and return false unless logged_in?
  end

  def logged_in?
    !!current_user_session
  end
end
