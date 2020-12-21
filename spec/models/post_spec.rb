require 'rails_helper'

RSpec.describe Post, type: :model do
  # let(:customer) { create(:customer) }
  context "データが正しく保存される" do
    before do
      # login_customer customer
      @customer = Customer.new
      @customer.id = 2
      @customer.username = "test"
      @customer.last_name = "test"
      @customer.first_name = "taro"
      @customer.email = "test@test"
      @customer.save
      @post = Post.new
      @post.body = "Hello"
      @post.reference = "NEW HORIZON"
      @post.tag_list_id = "BOOK"
      @post.customer = @customer
      @post.save
    end
    it "全て入力してあるので保存される" do
      expect(@post).to be_valid
    end
  end
end