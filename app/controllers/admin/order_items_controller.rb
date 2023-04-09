class Admin::OrderItemsController < ApplicationController
  def update
    @order_item = OrderItems.find(params[:id])
  end
  
end
