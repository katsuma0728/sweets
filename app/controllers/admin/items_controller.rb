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
     if params[:name]
       @items = Item.where("name LIKE?","%#{params[:name]}%")
    else
      @items = Item.all
    end
  end



  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_item_path(item.id)
  end

  private

  def item_params
    params.require(:item).permit(:id, :name, :price, :genre_id, :is_active, :image, :introduction)
  end
end
