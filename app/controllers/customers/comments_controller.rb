class Customers::CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(@comment.post.id)
    else
      @comments = Comment.all
      render :'customers/posts/show'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_customer.comments.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(@post.id)
  end

  def edit
  end

  def update
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :post_id, :customer_id)
  end

end
