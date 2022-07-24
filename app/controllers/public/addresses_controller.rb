class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

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
      redirect_to request.referer, notice: "住所登録に成功しました。"
    else
      @addresses = current_customer.addresses.page(params[:page])
      flash[:danger] = "住所登録に失敗しました。"
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先を保存しました。"
    else
      flash[:danger] = "配送先の保存に失敗しました。"
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

  def ensure_correct_user
    @address = Address.find(params[:id])
    unless @address.customer == current_customer
      flash[:danger] = "アカウントが違うため編集できません"
      redirect_to root_path
    end
  end
end
