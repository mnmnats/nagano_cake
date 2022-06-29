class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
    if order_detail.update(order_detail_params)
      count = 0
      order_detail.order.order_details.each do |order_detail|
        if order_detail.making_status == "制作完了"#製作完了だったらproduce_executed_countに1にその数を追加する
          count += 1
        end
      end
      if order_detail.making_status == "制作中"#order_detail.is_makingが製作中だったらorder_detail.order.is_orderを製作中にする
         order_detail.order.status = 2
      elsif
        count == order_detail.order.order_details.count#produce_executed_countがorder_detail.order.order_details.countと同じだったら
        order_detail.order.status = "発送準備中"
      end
      order_detail.order.save
      flash[:notice] = '更新されました。'
      redirect_to admin_order_path(order_detail.order_id)
    else
      @order = order_detail.order
      @order_details = @order.order_details
      render "orders/show"
    end
  end
  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end