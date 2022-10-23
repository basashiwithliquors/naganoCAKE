class Admin::ItemsController < ApplicationController

  before_action :authenticate_admin!
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render "error"
    end
  end

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_items_path
    else
      render "error"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :genre_id, :price_without_tax, :is_active, :image)
  end
end
