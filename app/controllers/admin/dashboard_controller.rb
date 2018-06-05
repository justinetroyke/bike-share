class Admin::DashboardController < Admin::BaseController
  def show
    category = params[:category]
    all = Order.all
    ordered = Order.ordered
    paid = Order.paid
    completed = Order.completed
    cancelled =  Order.cancelled

    @total_count = all.count
    @ordered_count = ordered.count
    @paid_count = paid.count
    @cancelled_count = cancelled.count
    @completed_count = completed.count
    if category.nil?
      @orders = all
    elsif category == 'ordered'
      @orders = ordered
    elsif category == 'paid'
      @orders = paid
    elsif category == 'cancelled'
      @orders = cancelled
    elsif category == 'completed'
      @orders = completed
    end
  end
end