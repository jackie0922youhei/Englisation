require 'rails_helper'

RSpec.describe DirectMessage, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(DirectMessage.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end

    context 'Roomモデルとの関係' do
      it 'N:1となっている' do
        expect(DirectMessage.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end