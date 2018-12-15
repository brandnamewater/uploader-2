class CustomerDashboardController < ApplicationController

  before_action :check_customer
  layout "customer_dashboard"



  def purchases
    @user = current_user
    orders = Order.where(buyer: current_user)
    orders_charged = orders.where(order_status: [2] )
    orders_created = orders.where(order_status: [1] )
    @orders_pending = orders_created.order('created_at DESC').paginate(:page => params[:orders_pending_page_1], :per_page => 8)
    @orders_charged = orders_charged.order('created_at DESC').paginate(:page => params[:orders_charged_page_1], :per_page => 8)
  end

  def buyer_dashboard

    @orders_g = Order.all.where(buyer: current_user).order('created_at DESC')
    @orders_e = Order.all.where(buyer: current_user).where(order_status: [2] ).paginate(:page => params[:month_orders_page_1], :per_page => 12)
    @orders_f = Order.all.where(buyer: current_user).where(order_status: [2] ).paginate(:page => params[:day_orders_page_1], :per_page => 7)

    @orders_month = @orders_e.all.group_by { |mon|  mon.created_at.beginning_of_month }
    @orders_day = @orders_f.all.group_by { |day|  day.created_at.beginning_of_day }

  end

end

  private

  def check_customer
    unless current_user.buyer?
      if current_user.seller?
        redirect_to '/', alert: "You must be signed-in to a customer account"
      else
        redirect_to '/', alert: "You must be signed-in"
     end
   end





end
