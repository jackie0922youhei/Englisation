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
  
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  
  def followed_by?(customer)
    passive_relationships.find_by(following_id: customer.id).present?
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
