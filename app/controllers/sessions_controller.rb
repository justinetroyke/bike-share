class SessionsController < ApplicationController
  def new
  end
  class CartCreator
    def initialize(session_id:)
      cart[:sesion_id] = session_id
      Cart.create!(session)
    end
  end
  def create
    user = User.find_by(username: params[:username])
    @cart = Cart.new(session)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
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
