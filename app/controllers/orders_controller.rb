class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @items = @order.items
    @user = @order.user
    require'pry';binding.pry
  end
end
