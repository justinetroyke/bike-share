class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    accessory = Accessory.find(params[:accessory_id])

    accessory_id = accessory.id.to_s
    cart = Cart.new(session[:cart])
    cart.add_accessory(accessory_id)
    session[:cart] = cart
    flash[:notice] = "#{cart.accessory_count(accessory_id)} #{accessory.title} has been added to your cart!"
    redirect_to accessories_path
  end

  def destroy
    @accessory = Accessory.find(params[:accesory_id])
    @cart.remove_accessory(@accessory.id.to_s)
    flash[:notice] = "Successfully removed #{@accessory.title} from your cart."
    flash[:link] = ["#{@accessory.title}", accessory_path(@accessory)]
    redirect_to '/cart'
  end

  def show
    @accessories = Accessory.where(id: @cart.contents.keys)
  end
end
