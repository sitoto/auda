class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    user.last_login_ip = remote_ip
    user.save
    session[:user_id] = user.id
    redirect_to root_path, notice: t("users.signedin")
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t("users.signedout")
  end

  def failure
    flash[:danger] =  t("users.authfailed")
    redirect_to root_path 
  end
end
