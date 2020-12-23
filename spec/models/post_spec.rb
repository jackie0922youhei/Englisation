require 'rails_helper'

RSpec.describe Post, type: :model do
  context "データが正しく保存される" do
    let(:customer) { create(:customer) }
    let!(:post) { create(:post, customer: customer) }
    it "全て入力してあるので保存される" do
      expect(post).to be_valid
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Reviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end

    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end
end