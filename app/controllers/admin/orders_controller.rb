class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = 0
  end
  
  def history
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == 1
      @order.order_details.update(making_status: 1)
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
  
  private
  def order_params
    params.require(:order).permit(:status)
  end
end
