class Public::CustomersController < ApplicationController

  def show
   @customer = current_customer
  end

  def edit
   @customer = current_customer
  end

  def update
   @customer = current_customer
   @customer.update(customer_params)
   redirect_to customers_mypage_path
  end

  def unsubscribe
  end

  def withdraw
  end

end
