class Notification < ApplicationRecord

  default_scope->{order(created_at: :desc)}

  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :review, optional: true
  belongs_to :action_customer, class_name: 'Customer', foreign_key: 'action_customer_id', optional: true
  belongs_to :reciever, class_name: 'Customer', foreign_key: 'reciever_id', optional: true

end
