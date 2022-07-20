class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all.order(id: "DESC").page(params[:page])
  end
end
