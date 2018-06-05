class Admin::DashboardController < Admin::BaseController
  def show
    category = params[:category]
    @total_count = Order.all.count
    @ordered_count = Order.ordered.count
    @paid_count = Order.paid.count
    @cancelled_count = Order.cancelled.count
    @completed_count = Order.completed.count

    if category.nil?
      @orders = Order.all
    elsif category == 'ordered'
      @orders = Order.ordered
    elsif category == 'paid'
      @orders = Order.paid
    elsif category == 'cancelled'
      @orders = Order.paid
    elsif category == 'completed'
      @orders = Order.paid
    end
  end
end