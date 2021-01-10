class Customers::CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    if @comment.save
      # 同一ユーザーからのpassive_notificationsが既に存在するかどうかをチェック(①)
      same_customer_notification = Notification.where(action_customer_id: current_customer.id, reciever_id: @post.customer.id, post_id: @post)
      # ①がfalseかつ、カレントユーザと投稿者が同一ユーザでないときに、通知を作成！
      if same_customer_notification.empty? && (current_customer.id != @post.customer.id)
        @comment.post.create_notification_comment!(current_customer, @comment.id)
      end
      redirect_to post_path(@post.id)
    else
      @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(5)
      @review = Review.new
      @reviews = @post.reviews.order(created_at: :desc).page(params[:page]).per(5)
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
