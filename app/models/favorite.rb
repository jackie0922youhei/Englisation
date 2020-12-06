class Favorite < ApplicationRecord

  belongs_to :customer
  belongs_to :post

  def self.create_notification
    Notification.create(visiter_id: customer_id, visited_id: post.customer_id, action: 'favorite', post_id: post_id)
  end

end
