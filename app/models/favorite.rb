class Favorite < ApplicationRecord

  belongs_to :customer
  belongs_to :post

  def create_notification
    Notification.create(action_customer_id: customer_id, reciever_id: post.customer_id, action: 'favorite', post_id: post_id)
  end

end
