class Public::ShippingAddressesController < ApplicationController

  before_action :authenticate_customer!
  before_action :ensure_correct_customer,only: [:edit, :update, :destroy]

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    if @shipping_address.save
      @shipping_addresses = ShippingAddress.where(customer_id: current_customer.id)
    else
      render "error"
    end
  end

  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = ShippingAddress.where(customer_id: current_customer.id)
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      redirect_to shipping_addresses_path
    else
      render "error"
    end
  end

  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.destroy
    @shipping_addresses = ShippingAddress.where(customer_id: current_customer.id)
  end

private

  def shipping_address_params
    params.require(:shipping_address).permit(:name, :address, :postcode).merge(customer_id: current_customer.id)
  end
  
  def ensure_correct_customer
    @shipping_address = ShippingAddress.find(params[:id])
    unless @shipping_address.customer == current_customer
      redirect_to shipping_addresses_path
    end
  end

end
