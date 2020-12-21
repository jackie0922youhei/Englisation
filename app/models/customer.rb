class Customer < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ログインする時に退会済み(is_deleted==true)のcustomerを弾くためのメソッド
  def active_for_authentication?
    # customerのis_deletedがfalseならtrueを返す
    super && (is_deleted == false)
  end

  validates :username, :email, :last_name, :first_name, presence: true

  attachment :image
  has_many :posts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :entries
  has_many :direct_messages
  has_many :rooms, through: :entries

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  has_many :active_notifications, class_name: "Notification", foreign_key: "action_customer_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "reciever_id", dependent: :destroy

  # customer_idを整数値でランダム生成する
  before_create :randomize_id

  def followed_by?(customer)
    passive_relationships.find_by(following_id: customer.id).present?
  end

  def create_notification_follow!(current_customer)
    temp = Notification.where(["action_customer_id = ? and reciever_id = ? and action = ? ", current_customer.id, id, 'follow'])
    if temp.blank?
      notification = current_customer.active_notifications.new(
        reciever_id: id,
        action: 'follow'
      )
      notification.save!
    end
  end

  # ゲストユーザーを探す or 作成する機能
  def self.guest
    find_or_create_by!(username: 'ゲストユーザー') do |guest|
      guest.password = SecureRandom.urlsafe_base64
      guest.email = 'sample' + '@' + SecureRandom.urlsafe_base64
      guest.last_name = 'サンプル'
      guest.first_name = '太郎'
    end
  end

  # is_teacher : booleanカラムで場合わけ
  after_create :assign_role

  def assign_role
    if is_teacher?
      add_role(:teacher)
    else
      add_role(:guest)
    end
  end

  private

  def randomize_id
    unless id == 1
      begin
        self.id = SecureRandom.random_number(1_000_000)
      end while Customer.where(id: id).exists?
    end
  end
end
