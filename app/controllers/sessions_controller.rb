class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: t("users.signedin")
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: t("users.signedout")
  end

  def failure
    redirect_to root_url, notice: t("users.authfailed")
  end
end
