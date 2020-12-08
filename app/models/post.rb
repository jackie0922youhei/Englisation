class Post < ApplicationRecord
  acts_as_taggable
  
  belongs_to :customer
  has_many :comments
  has_many :favorites
  has_many :reviews

  has_many :notifications, dependent: :destroy

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  def create_notification_comment!(current_customer, comment_id)
    comment = Comment.find(comment_id)
    save_notification_comment!(current_customer, comment.id, comment.customer_id)
  end

  def save_notification_comment!(current_customer, comment_id, reciever_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_customer.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      reciever_id: reciever_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.action_customer_id == notification.reciever_id
      notification.checked = true
    end
    notification.save!
  end

end
