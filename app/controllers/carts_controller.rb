class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    accessory = Accessory.find(params[:accessory_id])
    accessory_id = accessory.id.to_s
    session[:cart][accessory_id] = session[:cart][accessory_id] + 1
    @cart.add_accessory(accessory)
    session[:cart] = @cart.contents
    flash[:notice] = "#{}#{accessory.title} has been add to your cart!"
    redirect_to accessories_path
  end
end
