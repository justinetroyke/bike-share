class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    if current_user == @order.user || current_admin?
      @accessories = @order.accessories.uniq
      @user = @order.user
      @accessories_with_subtotal = @order.accessories_with_subtotal
    else
      @hide_nav = true
      render file: "/public/403", status: 403
    end
  end
end

