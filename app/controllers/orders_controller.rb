class OrdersController < ApplicationController
  # before_action :authenticate_member!
  
  # 注文情報入力画面
  def new 
    @order = Order.new
    @addresses = current_customer.shipping_addresses.all
  end
  
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def create
    @order = Order.new(order_params)
  end
  
  private
  def order_params
    params.require(:order).permit(:customer_id, :postage, :billing_amount, :payment_method, :name, :address, :post_code ,:order_status)
  end
end
