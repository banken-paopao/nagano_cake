class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = 0
  end
  
  def history
    @order = Order.find(params[:id])
    @orders = Order.where(customer_id: params[:id]).order(id: "DESC")
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if params[:order][:status] == "confirm"
      @order.order_details.each do |order_detail|
        order_detail.update(making_status: 1)
      end
    end
    redirect_to request.referer
  end
  
  private
  def order_params
    params.require(:order).permit(:status)
  end
end
