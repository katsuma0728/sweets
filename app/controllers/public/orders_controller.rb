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
    elsif params[:order][:address_number] = "2"
      @address = Address.new
      @order.shipping_address = params[:order][:shipping_address]
      @order.shipping_postal_code = params[:order][:shipping_postal_code]
      @order.shipping_name = params[:order][:shipping_name]
    end
    render :confirm
    @order.customer_id = current_customer.id
    @cart_items = CartItem.all(@order.customer_id)
    @total = 0
    @order.postage = 800
    @order.billing_amount = @total + @order.postage
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to complete_path
  end

  def complete
  end

  def index
  end

  def show
  end


  private

  def order_params
    params.require(:order).permit( :cutomer_id, :shipping_postal_code, :shipping_address, :shipping_name, :payment_method, :billing_amount)
  end
end
