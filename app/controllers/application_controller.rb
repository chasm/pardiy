class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :bool_to_text, :current_user
  
  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
  def is_authenticated
    redirect_to login_url unless current_user
  end
  
  def is_admin
    unless current_user
      redirect_to login_url
    else
      redirect_to root_url unless @current_user.is_superuser
    end
  end
  
  def bool_to_text(val)
    if val.nil?
      '<span class="unknown">unknown</span>'
    elsif val
      '<span class="yes">yes</span>'
    else
      '<span class="no">no</span>'
    end.html_safe
  end
    
end
