class Admin::DashboardController < Admin::BaseController
  def show
    @orders = Order.all
    @ordered = Order.ordered
    @paid = Order.paid
    @cancelled = Order.cancelled
    @completed = Order.completed
    require'pry';binding.pry
  end
end