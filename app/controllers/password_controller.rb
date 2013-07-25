class PasswordController < ApplicationController
  before_action :get_user
  after_action :clear_expired_codes
  
  # GET /reset/:code - display password reset form
  def edit
  end

  # PUT /reset/:code - update the user's password
  # PATCH /reset/:code
  def update
    if @user.update_attributes(user_params)
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Your password has been reset."
    else
      flash.now[:error] = "Password reset failed."
      render :edit
    end
  end
  
  private
  
  def get_user
    @user = User.find_by(code: params[:code])
    
    unless @user && @user.expires_at > Time.now
      redirect_to login_url, error: "Your reset code has expired."
    end
  end
  
  def clear_expired_codes
    User.where('expires_at < ?', Time.now)
      .update_all(code: nil, expires_at: nil)
  end
  
  def user_params
    params.require(:user).permit(
      :password,
      :password_confirmation
    )
  end
end
