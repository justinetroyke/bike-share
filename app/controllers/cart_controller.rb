class CartController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    flash[:notice] = "#{item.title} has been add to your cart!"
    redirect_to accessories_path
  end
end
