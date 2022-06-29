class Admin::CustomersController < ApplicationController
  def index
    @customers=Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer=Customer.find(params[:id])
  end

  def edit
    @customer=Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "successfully"
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:id,:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number,:email,:is_deleted)
  end
end