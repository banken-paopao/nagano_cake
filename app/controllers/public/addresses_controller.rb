class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = current_customer.addresses.page(params[:page])
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = "住所登録に成功しました。"
      redirect_to request.referer
    else
      @addresses = current_customer.addresses
      flash[:notice] = "住所登録に失敗しました。"
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "配送先を保存しました。"
      redirect_to addresses_path
    else
      flash[:notice] = "配送先の保存に失敗しました。"
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to request.referer
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
