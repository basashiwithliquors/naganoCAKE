class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all
    if params[:genre] != nil
      @genre_p = params[:genre]
      @genre_search = Item.where(is_active: true, genre_id: @genre_p)
      @items = @genre_search.order(created_at: :desc).page(params[:page]).per(8)
      @genre = Genre.find_by(id: @genre_p)
    elsif params[:word] != nil
      @word = params[:word]
      @word_search = Item.where(is_active: true).where("name like ?", "%#{@word}%")
      @items = @word_search.order(created_at: :desc).page(params[:page]).per(8)
    else
      @items = Item.where(is_active: true).order(created_at: :desc).page(params[:page]).per(8)
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
