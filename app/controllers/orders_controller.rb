class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @accessories = @order.accessories.uniq
    @user = @order.user
    @accessories_with_subtotal = @order.accessories_with_subtotal
  end
end
