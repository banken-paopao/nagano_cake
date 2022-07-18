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
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to request.referer
  end

  def create
    #カート内にある同じ商品をすべて取得
    now_cart = current_customer.cart_items.where(item_id: params[:cart_item][:item_id])
    cart_item = current_customer.cart_items.new(cart_item_params)
    unless now_cart.blank?
      #存在した時は購入個数を足して一つにまとめる
      now_cart.each do |item|
        cart_item.amount += item.amount
        item.destroy
      end
    end
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
