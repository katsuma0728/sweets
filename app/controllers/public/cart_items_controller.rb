class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :check_cart_items, only: [:create]

  def create
  if CartItem.exists?(item_id: params[:cart_item][:item_id], customer_id: current_customer.id)
     @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id], customer_id: current_customer.id)
     @cart_item.amount += params[:cart_item][:amount].to_i
     @cart_item.save!
  else
     @cart_item = CartItem.new(cart_item_params)
     @cart_item.customer_id = current_customer.id
     @cart_item.save!
  end
  redirect_to cart_items_path
end

  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end


  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end




  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

  def check_cart_items
    if params[:cart_item][:amount] == ""
      redirect_back fallback_location: root_path
    end
  end
end
