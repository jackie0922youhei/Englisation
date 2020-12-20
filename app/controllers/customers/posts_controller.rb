class Customers::PostsController < ApplicationController
  def index
    @customer = current_customer
    @teachers = Customer.all.where(is_teacher: true)
    @post = Post.new
    # ①Favorite.group(:post_id)：投稿の番号(post_id)が同じものにグループを分ける
    # ②order('count(post_id) desc')：いいねの多い順に並び替える
    # ③limit(10)：表示する最大数を10個に指定する
    # ④pluck(:post_id)：post_idカラムのみを数字で取り出すように指定
    # ⑤Post.find()：pluckで取り出される数字を投稿のIDとすることでいいね順にpostを取得する事ができる
    # @favorite_rankings = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
    # @comment_rankings = Post.find(Comment.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
    @favorite_rankings = Post.find(Favorite.group(:post_id).order(Arel.sql('count(post_id) desc')).limit(10).pluck(:post_id))
    @comment_rankings = Post.find(Comment.group(:post_id).order(Arel.sql('count(post_id) desc')).limit(10).pluck(:post_id))
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).per(7).order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(7)
    end
  end

  def create
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
    post = Post.new(post_params)
    post.customer_id = current_customer.id
    redirect_to root_path
    unless post.save
      @teachers = Customer.all.where(is_teacher: true)
      render :index
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @review = Review.new
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(5)
    @reviews = @post.reviews.order(created_at: :desc).page(params[:page]).per(5)
    if @post.reviews.blank?
      @average_review_rate = 0
    else
      @average_review_rate = @post.reviews.average(:rate).round(2)
    end
  end

  def edit
  end

  def update
    @post = Post.find(params[:id])
    @post.update!(post_update_params)
    render json: @post
  end

  def destroy
    @posts = Post.all.order(created_at: :desc)
    Post.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :customer_id, :reference, :tag_list)
  end

  def post_update_params
    params.require(:post).permit(:body)
  end

end
