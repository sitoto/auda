class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    user.last_login_ip = remote_ip
    user.save
    session[:user_id] = user.id
    Event.create!(name: 'login', username: user.name, status: '1', note: remote_ip, user: user)
    redirect_to root_path, notice: t("users.signedin")
  end

  def destroy
    Event.create!(name: 'logout', username: current_user.name, status: '1', note: remote_ip, user: current_user)
    session[:user_id] = nil
    redirect_to root_path, notice: t("users.signedout")
  end

  def failure
    Event.create!(name: 'login', username: '', status: '0', note: remote_ip )
    flash[:danger] =  t("users.authfailed")
    redirect_to root_path 
  end
end
