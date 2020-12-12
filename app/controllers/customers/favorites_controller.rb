class Customers::FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: @post.id)
    if favorite.save
      favorite.create_notification
    end
    render :create
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: @post.id)
    favorite.destroy
    render :destroy
  end
end
