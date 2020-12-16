# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :reject_customer, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def new_guest
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    posts_path
  end

  def reject_customer
    @customer = Customer.find_by(username: params[:customer][:username])
    if @customer
      # if (@customer.valid_password?(params[:customer][:password])で、入力されたパスワードが正しいことを確認
      # (@customer.active_for_authentication? == false))で、@customerのactive_for_authentication?メソッドがfalseであるかどうかを確認
      if (@customer.valid_password?(params[:customer][:password]) && (@customer.active_for_authentication? == false))
        flash[:error] = "退会済みです。"
        redirect_to new_customer_session_path
      else
        flash[:error] = "必須項目を入力してください。"
      end
    end
  end

end
