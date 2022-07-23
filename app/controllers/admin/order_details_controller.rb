class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = Order.find(@order_detail.order_id)
    if params[:order_detail][:making_status] == "now"
      @order_detail.order.update(status: 2)
    end
    if @order.order_details.all?{ |order_detail| order_detail.making_status == "finish"}
      @order_detail.order.update(status: 3)
    end
    redirect_to request.referer, notice: "注文詳細の編集に成功しました"
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
