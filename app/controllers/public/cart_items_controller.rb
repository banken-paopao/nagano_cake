class Public::CartItemsController < ApplicationController
  def index
    @all_with_tax_price = 0
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to request.referer
  end

  def destroy
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to request.referer
  end

  def create
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:amount)
  end
end
