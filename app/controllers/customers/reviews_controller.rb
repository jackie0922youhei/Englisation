class Customers::ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @post = Post.find(params[:post_id])
    if @review.save!
      render :create
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
    render :destroy
  end

  private
  def review_params
    params.require(:review).permit(:body, :post_id, :customer_id)
  end

end
