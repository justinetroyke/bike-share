class DashboardController < ApplicationController
  def show
    unless current_user
      flash[:notice] = "Looks like you may need to log in!"
      redirect_to login_path
    else
      @orders = current_user.orders
    end
  end
end
