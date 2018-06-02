class Admin::OrdersController < Admin::BaseController

  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:status].to_i)
    if @order.save
      flash[:notice] = "Order ##{@order.id} status changed to #{@order.status}"
      redirect_to admin_dashboard_path
    else
      flash[:error] = "We could not complete your request"
      redirect_to admin_dashboard_path
    end
  end
end
