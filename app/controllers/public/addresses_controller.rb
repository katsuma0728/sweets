class Public::AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  def create
    address = Address.new(address_params)
    address.customer_id = current_customer.id
    address.save
    redirect_to addresses_path
  end

  def index
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    address = Address.find(params[:id])
    address.update
    redirect_to addresses_path
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
