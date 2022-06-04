class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])

  end

  def edit
    @customer =Customer.find(params[:id])
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    redirect_to root_path
  end


end
