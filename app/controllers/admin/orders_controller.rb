class Admin::OrdersController < ApplicationController
  def show
    @order_detail = OrderDetail.find(params[:id])
    @order_details = OrderDetail.all
    @total = 0
  end
  
  def history
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end
  
  private
  def order_params
    params.require(:order).permit(:status)
  end
end
