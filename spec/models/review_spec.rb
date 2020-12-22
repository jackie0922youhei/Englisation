require 'rails_helper'

RSpec.describe Review, type: :model do
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