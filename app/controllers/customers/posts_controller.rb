class Customers::PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    @customer = current_customer
    @teachers = Customer.all.where(is_teacher: true)
    @post = Post.new
  end

  def create
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
    post = Post.new(post_params)
    post.customer_id = current_customer.id
    unless post.save
      @teachers = Customer.all.where(is_teacher: true)
      render :index
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @review = Review.new
  end

  def edit
  end

  def update
  end

  def destroy
    @posts = Post.all.order(created_at: :desc)
    Post.find(params[:id]).destroy
  end

  private
  def post_params
    params.require(:post).permit(:body, :customer_id, :reference, :tag_list)
  end

end
