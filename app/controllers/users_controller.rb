class UsersController < ApplicationController
  before_action :is_admin # admins only
  before_action :get_user, except: [ :index, :new, :create ]
  
  # GET /users - display all users
  def index
    @users = User.all
  end

  # GET /users/:id - display detail for user <id>
  def show
  end

  # GET /users/new - display new user form
  def new
    @user = User.new
  end

  # POST /users - create a new user
  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to user_path(@user), notice: "User #{@user.id} created."
    else
      flash.now[:error] = "Unable to create new user."
      render :new
    end
  end

  # GET /users/:id/edit - display the edit form for user <id>
  def edit
  end

  # PUT/PATCH /users/:id - update user <id>
  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user), notice: "User #{@user.id} updated."
    else
      flash.now[:error] = "Unable to update new user."
    end
  end

  # DELETE /users/:id - destroy user <id>
  def destroy
    @user.destroy
    
    redirect_to users_path, notice: "User #{params[:id]} deleted."
  end
  
  private
  
  def get_user
    @user = User.find(params[:id])
    
    redirect_to root_url unless @user
  end
  
  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation,
      :born_on,
      :zip_code,
      :bio,
      :is_superuser
    )
  end
end
