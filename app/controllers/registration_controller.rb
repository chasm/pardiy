class RegistrationController < ApplicationController
  # GET /register/:code - display registration form
  def new
    # Is there a registrant with the passed code?
    @registrant = Registrant.find_by(code: params[:code])
    
    if @registrant
      # Yes: Is the code expired?
      if @registrant.expires_at < Time.now
        # Yes: Redirect to login page with message
        redirect_to login_path, error: "Registration link expired."
      else
        # Create a new user with same email
        @user = User.new(email: @registrant.email)
      end
    else
      # No: Redirect to login page with message
      redirect_to login_path, error: "Registration link invalid."
    end
  end

  # POST /register/:code - create a new user
  def create
  end
end
