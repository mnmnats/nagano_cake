class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @orders = Order.all
    @order_items = OrderItem.all
  end

  def show
    @order = Order.find(params[:id])
    @order.shipping_cost = 800
    @order_items = OrderItem.all
    @total = 0
    
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path(order.id)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end