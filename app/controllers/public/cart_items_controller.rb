class Public::CartItemsController < ApplicationController
  def index
    # 消費税込みの合計の値段の初期定義
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
    cart_item = current_customer.cart_items.new(cart_item_params)
    if cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find(params[:cart_item][:item_id])
      @cart_item = CartItem.new
      @genres = Genre.all
      render 'public/items/show'
    end
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
