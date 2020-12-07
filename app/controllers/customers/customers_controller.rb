class Customers::CustomersController < ApplicationController
  before_action :check_guest, only: [:update, :withdraw]

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.all.order(created_at: :desc)
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: 'またのご利用をお待ちしております。'
  end

  def follows
    customer = Customer.find(params[:id])
    @customers = customer.followings
  end

  def followers
    customer = Customer.find(params[:id])
    @customers = customer.followers
  end

  # ゲストユーザーの削除機能・編集機能を制限
  def check_guest
    if current_customer.username == 'sample_user'
      redirect_to root_path, alert: 'ゲストユーザーは削除できません。'
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :username, :image, :telephone_number)
  end

end
