class Comment < ApplicationRecord

  belongs_to :customer
  belongs_to :post
  
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

end
