class Cpanel::ApplicationController < ApplicationController
  #  layout "cpanel"
  before_filter :require_user
  before_filter :require_admin

  def require_admin
    unless current_user.has_role?("admin")
      redirect_to root_url, notice: t("users.authfailed")
    end
  end
end
