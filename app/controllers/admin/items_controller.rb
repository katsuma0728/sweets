class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def index
     if params[:name]
       @items = Item.where("name LIKE?","%#{params[:name]}%").page(params[:page])
    else
      @items = Item.all.page(params[:page])
    end
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
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:id, :name, :price, :genre_id, :is_active, :image, :introduction)
  end
end
