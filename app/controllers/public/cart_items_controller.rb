class Public::CartItemsController < ApplicationController
  def index
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to request.referer
  end

  def destroy
  end

  def destroy_all
  end

  def create
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:amount)
  end
end
