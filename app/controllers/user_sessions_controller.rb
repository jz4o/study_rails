class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new user_session_params.to_h

    if @user_session.save
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to login_url
  end

  private

  def user_session_params
    params.require(:user_session).permit(%i[email password])
  end
end
