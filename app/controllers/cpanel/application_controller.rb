class Cpanel::ApplicationController < ApplicationController
  layout "cpanel"
  before_filter :require_user
  before_filter :require_admin

  def require_admin
    unless current_user.admin? || current_user.email.eql?('huangw@jiaparts.com')
      flash[:danger] = t("cancanerror")
      redirect_to root_url
    end
  end


end
