require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "コメントが正しく保存される" do
    it "全ての項目を入力すれば保存できる" do
      comment = build(:comment)
      expect(comment).to be_valid
    end

    it "bodyがなければ保存できない" do
      comment = build(:comment, body: nil)
      expect(comment.valid?).to eq(false)
      expect(comment.errors[:body]).to include("を入力してください")
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Comment.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end