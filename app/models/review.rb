class Review < ApplicationRecord

  belongs_to :customer
  belongs_to :post

  has_many :notifications, dependent: :destroy

  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0
  }, presence: true

end
