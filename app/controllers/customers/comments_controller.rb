class Customers::CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(5)
    if @comment.save
      #通知の作成
      @comment.post.create_notification_comment!(current_customer, @comment.id)
      redirect_back(fallback_location: root_path)
    else
      render :'customers/posts/show'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_customer.comments.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.find_by(id: params[:id], post_id: params[:post_id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.find_by(id: params[:id], post_id: params[:post_id])
    if @comment.update(comment_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :post_id, :customer_id)
  end

end
