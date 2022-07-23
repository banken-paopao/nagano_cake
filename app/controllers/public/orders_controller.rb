class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_user, only: [:show]

  def new
    if current_customer.cart_items.blank?
      redirect_to root_path
    else
      @address = Address.new
      @order = Order.new
    end
  end

  def confirm
    @all_with_tax_price = 0
    @order = Order.new(order_params)
    select_address = params[:order][:select_address]
    case select_address
    when '0' then
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    when '1' then
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    when '2' then
      @address = current_customer.addresses.new(postal_code: @order.postal_code, address: @order.address, name: @order.name)
      if @address.save
        @address.destroy
      else
        render :new
      end
    else
      render :new
    end
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      current_customer.cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.with_tax_price
        order_detail.save
      end
      customer = current_customer
      unless  customer.postal_code == @order.postal_code && customer.address == @order.address && customer.full_name == @order.name
        # オーダーに登録された配送先がカスタマー住所じゃない時の処理
        count = 0
        customer.addresses.each do |address|
          unless address.postal_code == @order.postal_code && address.address == @order.address && address.name == @order.name
            # オーダーに登録された配送先が配送先一覧に登録されていない時にカウントを行う
            count += 1
          end
        end
        # すべての住所と一致しない時新しい配送先として保存する
        if customer.addresses.size == count
          address = Address.new
          address.customer_id = current_customer.id
          address.postal_code = @order.postal_code
          address.address = @order.address
          address.name = @order.name
          address.save
        end
      end
      customer.cart_items.destroy_all
      redirect_to complete_orders_path
    else
      @order = Order.new(order_params)
      flash[:danger] = "情報が正しく入力されていません"
      render :new
    end
  end

  def index
    @orders = current_customer.orders.page(params[:page])
  end

  def show
    # 注文完了画面からページを戻ろうとするとshow画面に行くのを阻止
    if params[:id] == 'confirm'
      redirect_to root_path
    else
      @order = Order.find(params[:id])
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment)
  end

  def ensure_correct_user
    @order = Order.find(params[:id])
    unless @order.customer == current_customer
      flash[:danger] = "アカウントが違うため閲覧できません"
      redirect_to root_path
    end
  end
end
