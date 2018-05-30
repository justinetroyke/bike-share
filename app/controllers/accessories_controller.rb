class AccessoriesController < ApplicationController
  def index
<<<<<<< HEAD
    @accessories = Accessory.all
    @cart = Cart.new(session[:cart])
=======
    @items = Item.all
>>>>>>> WIP cart contents causing an error in carts controller
  end

  def show
    @accessory = Accessory.find(params[:id])
  end
end
