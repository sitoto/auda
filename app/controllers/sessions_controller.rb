class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    Event.create!(name: t("users.signedin"), username: user.name, status: '1', note: "#{user.email}/#{remote_ip}" , user: user)
    redirect_to sessions_new_path, notice: t("users.signedin")
  end

  def destroy
    Event.create!(name: t("users.signedout"), username: session[:user_id] , status: '1', note: '' )
    session[:user_id] = nil
    redirect_to sessions_new_path, notice: t("users.signedout")
  end

  def failure
    Event.create!(name: t("users.authfailed"), username: '', status: '0', note: remote_ip )
    flash[:danger] =  t("users.authfailed")
    redirect_to sessions_new_path 
  end
end
