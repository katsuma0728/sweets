class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_number] = "0"
      @order.shipping_address = current_customer.address
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_number] = "1"
      @address = Address.find(params[:order][:address_id])
      @order.shipping_address = @address.address
      @order.shipping_postal_code = @address.postal_code
      @order.shipping_name = @address.name
    else params[:order][:address_number] = "2"
      @order.shipping_address = params[:order][:shipping_address]
      @order.shipping_postal_code = params[:order][:shipping_postal_code]
      @order.shipping_name = params[:order][:shipping_name]
    end
      @cart_items = current_customer.cart_items
      @total = 0
      @order.postage = 800
     render :confirm
  end

  def create
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.save

    current_customer.cart_items.each do |cart_item|
    @order_item = OrderItem.new
    @order_item.item_id = cart_item.item_id
    @order_item.order_id = order.id
    @order_item.purchase_price = cart_item.item.with_tax_price
    @order_item.amount = cart_item.amount
    @order_item.save
  end

    current_customer.cart_items.destroy_all
    redirect_to complete_path
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total = 0
  end


  private

  def order_params
    params.require(:order).permit( :id, :customer_id, :shipping_postal_code, :shipping_address, :shipping_name, :payment_method, :billing_amount, :postage, :order_status)
  end
end
