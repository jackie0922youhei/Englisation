class Customers::ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @post = Post.find(params[:post_id])
    @reviews = @post.reviews.order(created_at: :desc).page(params[:page]).per(7)
    if @review.save
      #通知の作成
      @review.post.create_notification_review!(current_customer, @review.id)
      redirect_back(fallback_location: root_path)
    else
      render :'customers/posts/show'
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @review = current_customer.reviews.find_by(id: params[:id], post_id: params[:post_id])
  end

  def update
    @post = Post.find(params[:post_id])
    @review = current_customer.reviews.find_by(id: params[:id], post_id: params[:post_id])
    if @review.update(review_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_customer.reviews.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(@post)
  end

  private
  def review_params
    params.require(:review).permit(:body, :post_id, :customer_id).merge(rate: params['score']['rate'])
  end

end
