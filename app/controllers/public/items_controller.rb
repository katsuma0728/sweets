class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all

    if params[:name]
       @items = Item.where("name LIKE?","%#{params[:name]}%").page(params[:page]).per(8)
    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page]).per(8)
      @items_count = @items.count
      @genre_flag = true
    else
      @genre_flag = false
      @items = Item.all.page(params[:page]).per(8)
      @items_count = Item.count
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
