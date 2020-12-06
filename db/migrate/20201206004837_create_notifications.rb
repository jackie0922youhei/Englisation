class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :action_customer_id
      t.integer :reciever_id
      t.integer :comment_id
      t.string :action
      t.boolean :checked, default: false, null: false
      t.integer :review_id
      t.integer :post_id

      t.timestamps
    end
  end
end
