class Customer < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  
  attachment :image
  has_many :posts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
  
  # is_teacher : booleanカラムで場合わけ
  after_create :assign_role
  
  def assign_role
    if self.is_teacher?
      self.add_role(:teacher) 
    else
      self.add_role(:guest)
    end
  end

end
