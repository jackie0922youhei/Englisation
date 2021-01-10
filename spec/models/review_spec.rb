require 'rails_helper'

RSpec.describe Review, type: :model do
  context "レビューが正しく保存される" do
    it "全ての項目を入力すれば保存できる" do
      review = build(:review)
      expect(review).to be_valid
    end

    it "usernameがなければ保存できない" do
      review = build(:review, body: nil)
      expect(review.valid?).to eq(false)
      expect(review.errors[:body]).to include("を入力してください")
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Review.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end