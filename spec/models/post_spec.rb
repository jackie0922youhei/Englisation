require 'rails_helper'

RSpec.describe Post, type: :model do
  context "データが正しく保存される" do
    before do
      @post = Post.new
      @post.body = "Hello"
      @post.reference = "NEW HORIZON"
      @post.tag_list_id = "BOOK"
      @post.customer.id = current_customer.id
      @post.save
    end
    it "全て入力してあるので保存される" do
      expect(@post).to be_valid
    end
  end
end