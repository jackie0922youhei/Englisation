class Customers::RelationshipsController < ApplicationController
  def create
    follow = current_customer.active_relationships.build(follower_id: params[:customer_id])
    follow.save
    @customer = current_customer
    #通知の作成
    followed_customer = Customer.find(params[:customer_id])
    followed_customer.create_notification_follow!(current_customer)
    render :create
  end

  def destroy
    follow = current_customer.active_relationships.find_by(follower_id: params[:customer_id])
    follow.destroy
    @customer = current_customer
    render :destroy
  end
end
