class Admin::ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      redirect_to request.referer
    end
  end
  
  def index
    @items = Item.all
  end
  
  def item_params
    params.require(:item).permit(:name, :description, :genre_id, :price_without_tax, :is_active, :image)
  end
end
