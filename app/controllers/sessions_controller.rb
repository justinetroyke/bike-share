class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if current_admin?
        flash[:notice] = "Logged in as Admin User: #{current_user.username}"
        redirect_to admin_dashboard_path
      else
        flash[:notice] = "Logged in as User: #{current_user.username}"
        redirect_to dashboard_path
      end
    else
      flash[:notice] = "Sorry, those credentials were incorrect. Please try again!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
