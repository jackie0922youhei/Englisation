class Post < ApplicationRecord

  belongs_to :customer
  has_many :comments
  has_many :favorites
  has_many :reviews
  
  has_many :notifications, dependent: :destroy
  
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
  
  def create_notification_by(current_customer)
    notification = current_customer.active_notifications.new(
      post_id: id,
      visited_id: customer_id,
      action: "favorite"
    )
    notification.save if notification.valid?
  end
  
  def create_notification_comment!(current_customer, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:customer_id).where(post_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_customer, comment_id, temp_id['customer_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_customer, comment_id, customer_id) if temp_ids.blank?
  end
  
  def save_notification_comment!(current_customer, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_customer.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
