class Customers::PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    @customer = current_customer
    @teachers = Customer.all.where(is_teacher: true)
    @post_new = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      @posts = Post.all.order(created_at: :desc)
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
    @post = current_customer.posts.find_by(params[:id]).destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:body, :customer_id, :reference, :tag_list_id)
  end

end
