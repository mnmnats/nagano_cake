class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders
  end

  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0
    @order.save
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.price = cart_item.item.price
      @order_detail.amount = cart_item.amount
      @order_detail.making_status = 0
      @order_detail.save
    end

    current_customer.cart_items.destroy_all
    redirect_to complete_order_path
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details.all
    @order.shipping_cost = 800
    @order_details = @order.customer.cart_items.all
    @total = @order.total_payment - @order.shipping_cost
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.payment_method = params[:order][:payment_method]
    total = 0
    @cart_items.each do |cart_item|
     total += cart_item.subtotal
    end
    @total_payment = total
    @order.shipping_cost = 800
    address_select = params[:order][:address_select]
    if address_select == "0"
      @address = current_customer.address
      @postal_code = current_customer.postal_code
      @name = current_customer.full_name
    elsif address_select == "1"
      address = Address.find(params[:order][:address_id])
      @address = address.address
      @postal_code = address.postal_code
      @name = address.name
    elsif address_select == "2"
      @address = params[:order][:address]
      @postal_code = params[:order][:postal_code]
      @name = params[:order][:name]
    end
  end

  def thanks
  end


  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :address_select)
  end

  def address_params
    params.require(:address).permit(:customer_id, :postal_code, :address, :name)
  end



end