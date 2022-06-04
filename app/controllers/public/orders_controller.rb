class Public::OrdersController < ApplicationController
  def new
      @order = Order.new
  end

 def confirm
    @order = Order.new(order_params)
    if params[:order][:order_address] == "0"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:order_address] == "1"
      @sipmemt_address = Address.find(params[:order][:address_id])
      @order.name = @sipmemt_address.name
      @order.address = @sipmemt_address.address
      @order.postcode = @sipmemt_address.postcode
    elsif params[:order][:order_address] == "2"
      @order.name = params[:order][:name]
      @order.address = params[:order][:address]
      @order.postcode = params[:order][:postcode]
    end
      @cart_item = CartItem.all
      @order.postage = 800
      @total = 0

 end

def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_item = OrderItem.new
      @order_item.order_id = @order.id
      @order_item.item_id = cart_item.item.id
      @order_item.quantity = cart_item.quantity
      @order_item.total_payment = (cart_item.item.price) * (cart_item.quantity) *1.1
      @order_item.save
    end
    @cart_items.destroy_all
    redirect_to public_thankyou_path
end

 def thankyou
 end




 def index
    @orders = Order.all

 end




  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items

  end



   private
  def order_params
    params.require(:order).permit(:status, :postcode, :address, :name, :postage, :total_payment, :payment_method)
  end
end