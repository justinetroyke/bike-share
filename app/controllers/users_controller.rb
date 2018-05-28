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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :username, :password)
  end
end