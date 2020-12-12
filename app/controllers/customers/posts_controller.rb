class Customers::PostsController < ApplicationController
  def index
    @customer = current_customer
    @teachers = Customer.all.where(is_teacher: true)
    @post = Post.new
    # ①Favorite.group(:post_id)：投稿の番号(postid)が同じものにグループを分ける
    # ②order('count(post_id) desc')：いいねの多い順に並び替える
    # ③limit(10)：表示する最大数を10個に指定する
    # ④pluck(:post_id)：post_idカラムのみを数字で取り出すように指定
    # ⑤Post.find()：pluckで取り出される数字を投稿のIDとすることでいいね順にpostを取得する事ができる
    @favorite_rankings = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
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
