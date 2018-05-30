class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @items = @order.items.uniq
    @user = @order.user
    @items_with_subtotal = @order.items_with_subtotal
  end
end
