class SessionController < ApplicationController
  # GET /login - log in form
  def new
  end

  # POST /login - create a new user session
  def create
    puts params[:user]
    # Is the email blank?
    if params[:user][:email].blank?
      puts "Email blank"
      # Yes: Rerender login page with error message
      flash.now[:error] = "You must enter an email address."
      render :new
    else
      puts "Email not blank"
      # No: Does the user exist?
      @user = User.find_by(email: params[:user][:email])
      
      if @user
        puts "User exists"
        # Yes: Is the password blank?
        if params[:user][:password].blank?
          puts "Password blank"
          # Set a code and expires_at time on the user
          @user.code = SecureRandom.urlsafe_base64
          @user.expires_at = Time.now + 4.hours
          @user.save
          # TODO: Send an email with a coded reset link
          # Redirect to the login page with message
          redirect_to login_path,
            notice: "A password reset email has been sent to you."
        else
          puts "Password not blank"
          # No: TODO: Is user authenticated?
          if @user.authenticate(params[:user][:password])
            puts "User authenticated"
            # Yes: Set the session user_id and redirect to /
            session[:user_id] = @user.id
            redirect_to root_url
          else
            puts "User not authenticated"
            # No: Rerender the login page with error message
            flash.now[:error] = "Wrong email or password. Try again?"
            render :new
          end
        end
      else
        puts "User does not exist"
        # Create a new registrant with email, code, expires_at
        @registrant = Registrant.new(email: params[:user][:email])
        @registrant.code = SecureRandom.urlsafe_base64
        @registrant.expires_at = Time.now + 1.day
        @registrant.save
        # TODO: Send an email with a coded registration link
        # Redirect to the login page with message
        redirect_to login_path,
          notice: "A registration email has been sent to you."
      end
    end
  end

  # DELETE /logout - log the user out
  # GET /logout
  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "You've succesfully logged out."
  end
end
