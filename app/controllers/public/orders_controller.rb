class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    redirect_to confirm_order_path(params[:id])
  end

  def complete
  end

  def index
  end

  def show
  end

  def confirm
  end

  private

  def order_params
    params.require(:order).permit(:id, :customer_id, :address)
  end
end
