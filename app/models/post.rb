class Post < ApplicationRecord

  belongs_to :customer
  has_many :comments
  has_many :favorites
  has_many :reviews
  
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

end
