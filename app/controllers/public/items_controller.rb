class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all
    if params[:genre] == nil
      @items = Item.where(is_active: true).order(created_at: :desc).page(params[:page]).per(8)
    else
      @items = Item.where(is_active: true, genre_id: params[:genre]).order(created_at: :desc).page(params[:page]).per(8)
      @genre = Genre.find_by(id: params[:genre])
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
    if @item.is_active == false
      redirect_to items_path
    end
  end
 
end
