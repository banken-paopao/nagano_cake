class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
  end

  def history
    @customer = Customer.find(params[:id])
    @orders = Order.where(customer_id: params[:id]).order(id: "DESC").page(params[:page])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if params[:order][:status] == "confirm"
      @order.order_details.each do |order_detail|
        order_detail.update(making_status: 1)
      end
    end
    redirect_to request.referer, notice: "注文詳細の編集に成功しました"
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
