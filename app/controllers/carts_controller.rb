class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
<<<<<<< HEAD
    accessory = Accessory.find(params[:accessory_id])
    accessory_id = accessory.id.to_s
    session[:cart][accessory_id] = session[:cart][accessory_id] + 1
    @cart.add_accessory(accessory)
    session[:cart] = @cart.contents
    flash[:notice] = "#{}#{accessory.title} has been add to your cart!"
=======
    item = Item.find(params[:item_id])

    item_id = item.id.to_s
    cart = Cart.new(session[:cart])
    cart.add_item(item_id)
    session[:cart] = cart
    flash[:notice] = "#{cart.item_count(item_id)} #{item.title} has been added to your cart!"

>>>>>>> WIP cart
    redirect_to accessories_path
  end
end
