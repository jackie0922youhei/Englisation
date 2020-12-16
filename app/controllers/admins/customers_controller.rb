class Admins::CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.all.order(created_at: :desc)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admins_customer_path(@customer.id)
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :username, :image, :telephone_number, :is_teacher, :is_deleted)
  end

end
