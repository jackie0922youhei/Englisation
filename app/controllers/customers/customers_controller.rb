class Customers::CustomersController < ApplicationController
  before_action :check_guest, only: [:update, :withdraw]

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.all.order(created_at: :desc)
    # チャット
    if customer_signed_in?
      # Entry内のcustomer_idがcurrent_customerと同じEntry
      @current_customer_entries = Entry.where(customer_id: current_customer.id)
      # Entry内のcustomer_idがMYPAGEのparams.idと同じEntry
      @customer_entries = Entry.where(customer_id: @customer.id)
      # @customer.idとcurrent_customer.idが同じでなければ
      unless @customer.id == current_customer.id
        @current_customer_entries.each do |current_customer_entry|
          @customer_entries.each do |customer_entry|
            # もしcurrent_customer側のルームidと＠customer側のルームidが同じであれば存在するルームに飛ぶ
            if current_customer_entry.room_id == customer_entry.room_id
              @room_existance = true
              @room_id = current_customer_entry.room_id
            end
          end
        end
        # ルームが存在していなければルームとエントリーを作成する
        unless @room_existance
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
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
      redirect_to root_path, notice: 'ゲストユーザーの編集・削除はできません！'
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :email, :username, :image)
  end
end
