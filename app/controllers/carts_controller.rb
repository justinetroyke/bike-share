class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    accessory = Accessory.find(params[:accessory_id])

    # accessory_id = accessory.id.to_s
    cart = Cart.new(session[:cart])
    cart.add_accessory(accessory)
    session[:cart] = cart
    flash[:notice] = "#{cart.accessory_count(accessory.id)} #{accessory.title} has been added to your cart!"

    redirect_to accessories_path
  end

  def show
    @cart_contents = session[:cart]["contents"]
  end
end
