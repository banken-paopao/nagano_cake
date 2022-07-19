class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all.order(id: "DESC")
  end
end
