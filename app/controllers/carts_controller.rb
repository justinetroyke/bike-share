class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    accessory = Accessory.find(params[:accessory_id])
    @cart.add_accessory(accessory)
    session[:cart] = @cart.contents
    flash[:notice] = "#{accessory.title} has been add to your cart!"
    redirect_to accessories_path
  end
end
