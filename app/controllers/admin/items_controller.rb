class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  
  def create
    item = Item.new(item_params)
    item.save
    redirect_to admin_item_path(item.id)
  end
  
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end
  
  private
  
  def item_params
    params.require(:item).permit(:id, :name, :price, :genre_id, :is_active)
  end
end
