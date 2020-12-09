class Customers::PostsController < ApplicationController
  def index
    @customer = current_customer
    @teachers = Customer.all.where(is_teacher: true)
    @post = Post.new
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    else
    @posts = Post.all.order(created_at: :desc)
    end
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
    if @post.reviews.blank?
      @average_review_rate = 0
    else
      @average_review_rate = @post.reviews.average(:rate).round(2)
    end
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
