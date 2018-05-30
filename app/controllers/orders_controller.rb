class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @items = @order.items
    @user = @order.user
  end
end
