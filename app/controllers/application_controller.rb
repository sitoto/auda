class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :use_special_port if Rails.env == 'production'

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :notice => t('cancanerror') #exception.message
  end

  def use_special_port
    class << request
      def port 
        if remote_ip.eql?('server')
          80
        else
          8181 
        end
      end
    end
  end


  #  before_filter do
  #    resource = controller_name.singularize.to_sym
  #    method = "#{resource}_params"
  #    params[resource] &&= send(method) if respond_to?(method, true)
  #  end
  #


  def remote_ip
    if request.remote_ip == '127.0.0.1'
      'server'
    else
      request.remote_ip
    end
  end  



  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_user
    if current_user.blank?
      respond_to do |format|
        format.html {
          redirect_to root_url, notice: t('users.nologin')
        }
        format.all {
          head(:unauthorized)
        }
      end
    end
  end

end
