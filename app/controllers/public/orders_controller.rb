class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  # 注文情報入力画面
  def new
    @order = Order.new
    @addresses = current_customer.shipping_addresses.all
  end

  # 注文情報入力確認画面
  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
    @order.postage = 800

    # [:address_option]=="0"のデータ(customerの住所)を呼び出す
    if params[:order][:address_option] == "0"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

      # [:address_option]=="1"を呼び出す
    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:customer_id])
      #orderのcustomer_id(=カラム)でアドレス(帳)を選び、そのデータ送る
      @order.postcode = ship.post_code
      @order.address = ship.address
      @order.name = ship.name

      # 新規住所入力 [:address_option]=="2"としてデータをhtmlから受ける
    elsif params[:order][:address_option] = "2"
      @order.postcode = params[:order][:postcode]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render 'new'
    end
  end

  # 注文情報保存
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    # order_itmesに保存
    current_customer.cart_items.each do |cart_item| #カート内商品を1つずつ取り出しループ
      @order_item = OrderItem.new #初期化宣言
      @order_item.order_id =  @order.id #order注文idを紐付けておく
      @order_item.item_id = cart_item.item_id #カート内商品idを注文商品idに代入
      @order_item.quantity = cart_item.quantity #カート内商品の個数を注文商品の個数に代入
      @order_item.buying_price = (cart_item.item.price*1.08).floor #消費税込みに計算して代入
      @order_item.save #注文商品を保存
    end #ループ終わり

    current_customer.cart_items.destroy_all #カートの中身を削除
    redirect_to complete_order_path
  end

  # 注文完了画面
  def complete
  end

  # 注文履歴一覧
  def index
    @orders = current_customer.orders
  end

  # 注文履歴詳細
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postage, :billing_amount, :payment_method, :name, :address, :postcode ,:order_status)
  end
end
