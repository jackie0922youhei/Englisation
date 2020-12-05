class Comment < ApplicationRecord

  belongs_to :customer, optional: true
  belongs_to :post, optional: true

end
