class Customers::PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    @customer = current_customer
    @teachers = Customer.all.where(is_teacher: true)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to posts_path
    else
      @posts = Post.all.order(created_at: :desc)
      @customer = current_customer
    @teachers = Customer.all.where(is_teacher: true)
      render :index
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:body, :customer_id, :reference, :tag_list_id)
  end

end
