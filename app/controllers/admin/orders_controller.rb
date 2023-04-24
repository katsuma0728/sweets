class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total = 0
  end

  def update
    @order = Order.find(params[:id])
      if @order.update(order_params)
        @order_items = @order.order_items
         @order_items.update_all(production_status: 1) if @order.order_status == "payment_confirmation"
        ## ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
      end
    redirect_to admin_order_path(@order)
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end
end
