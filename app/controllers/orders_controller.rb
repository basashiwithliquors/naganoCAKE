class OrdersController < ApplicationController
  before_action :authenticate_customer!

  # 注文情報入力画面
  def new
    @order = Order.new
    @addresses = current_customer.shipping_addresses.all
  end

  def confirm   # 注文情報入力確認画面
    @order = Order.new(order_params)

    # [:address_option]=="0"のデータ(customerの住所)を呼び出す
    if params[:order][:address_option] == "0"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @order.payment_method = params[:order][:payment_method]
    
      # [:address_option]=="1"を呼び出す
    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:customer_id])
      #orderのcustomer_id(=カラム)でアドレス(帳)を選び、そのデータ送る
      @order.postcode = ship.post_code
      @order.address = ship.address
      @order.name = ship.name
      
      # 新規住所入力 [:address_option]=="2"としてデータをhtmlから受ける
    elsif params[:order][:address_option] = "2"
      @order.postcode = params[:order][:shipping_postcode]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render 'new'
    end
    
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
