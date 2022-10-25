class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @cart_items = CartItem.all
    @cart_items = current_customer.cart_items
    @sum = 0
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end 
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end 
  
  # カート内商品全て削除
  def destroy_all
    @cart_items = CartItem.all
    @cart_items = current_customer.cart_items
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end 
  

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    # 追加した商品がカート内に存在するか判別
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
        #元々カート内にあるもの「item_id」
        #今追加したparams[:cart_item][:item_id])
        cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        cart_item.quantity += params[:cart_item][:quantity].to_i
        #cart_item.quantityに今追加したparams[:cart_item][:quantity]を加える
        cart_item.save
        redirect_to cart_items_path
    # もしカート内に「同じ」商品がない場合は通常の保存処理
    elsif @cart_item.save
      redirect_to cart_items_path
    # 保存できなかった場合  
    else 
      redirect_to request.referer
    end
  end
  
  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :quantity, :customer_id)
  end
  
end
