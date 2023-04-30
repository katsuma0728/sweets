class Admin::OrdersController < ApplicationController
  def index
    if params[:customer_id] && Order.find_by(customer_id: params[:customer_id])
      @customer = Customer.find(params[:customer_id])
      @orders = @customer.orders.page(params[:page])
      @customer_flag = true
    else
      @customer_flag = false
      @orders = Order.all.page(params[:page])
    end
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
      end
    redirect_to admin_order_path(@order)
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end
end
