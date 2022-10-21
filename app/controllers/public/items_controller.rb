class Public::ItemsController < ApplicationController

  def index
    @items = Item.where(is_active: true).order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    if @item.is_active == false
      redirect_to public_items_path
    end
  end
 
end
