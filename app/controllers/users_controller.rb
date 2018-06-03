class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create!(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{current_user.username}"
      redirect_to dashboard_path
    else
      flash[:notice] = 'Registration Failed. Please check the information you entered and try again'
      render :new
    end
  end

  def edit
    if params[:id].to_i == current_user.id
      @user = User.find(current_user.id)
    else
      @hide_nav = true
      render file: "/public/403", status: 403
    end
  end

  def update
    @user = User.find(current_user.id.to_s)
    @user.update(user_params)  if params[:user][:password] == current_user.password 
    if @user.save!
      flash[:notice] = "Your information has been updated"
      redirect_to dashboard_path
    else
      flash[:error] = "Invalid credentials"
      redirect_to edit_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :username, :password)
  end
end