class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to my_page_customers_path, notice: "会員情報の編集に成功しました"
    else
      flash[:danger] = "会員情報の編集に失敗しました"
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    current_customer.update(is_deleted: true)
    sign_out current_customer
    redirect_to root_path, notice: "正常に退会しました"
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
