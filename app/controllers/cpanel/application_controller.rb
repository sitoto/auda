class Cpanel::ApplicationController < ApplicationController
#  layout "cpanel"
  before_filter :require_user
  before_filter :require_admin

  def require_admin
    unless current_user.role.to_s == "admin" || current_user.email.to_s == "huangw@jiaparts.com"
        redirect_to root_url, notice: t("users.authfailed")
    end
  end
end
