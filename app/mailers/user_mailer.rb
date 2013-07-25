class UserMailer < ActionMailer::Base
  default from: "funfolks@pardiy.me"

  def reset_link(user)
    @user = user
    
    mail to: user.email, subject: "Reset your ParDIY credentials"
  end

  def register_link(user)
    @user = user
    
    mail to: user.email, subject: "Reset your ParDIY credentials"
  end

  def register_congrats(user)
    @user = user
    
    mail to: user.email, subject: "Reset your ParDIY credentials"
  end

  def goodbye(user)
    @user = user
    
    mail to: user.email, subject: "Reset your ParDIY credentials"
  end
end
