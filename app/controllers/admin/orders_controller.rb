class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:id]
      @orders = Customer.find(params[:id]).orders.page(params[:page]).per(10)
    elsif request.fullpath.include? "today"
      @orders = Order.where(created_at:  Time.zone.now.all_day).page(params[:page]).per(10)
    elsif request.fullpath.include? "yesterday"
      @orders = Order.where(created_at: 1.day.ago.all_day).page(params[:page]).per(10)
    else
      @orders = Order.page(params[:page]).per(10)
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_item = OrderItem.where(order_id: @order.id)
    @customer = @order.customer
  end

  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    if @order.update(order_params)
      if @order.order_status == "payment_confirmation"
        @order_items.each do |order_item|
          order_item.update(production_status: "waiting_for_making")
        end
      end
      redirect_to admin_order_path
    else
      redirect_to admin_order_path
    end
  end

  protected

  def order_params
    params.require(:order).permit(:customer_id, :postage, :billing_amount, :payment_method, :name, :address, :postcode ,:order_status)
  end
end
