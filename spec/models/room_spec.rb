require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Entryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Room.reflect_on_association(:entries).macro).to eq :has_many
      end
    end

    context 'DirectMessageモデルとの関係' do
      it '1:Nとなっている' do
        expect(Room.reflect_on_association(:direct_messages).macro).to eq :has_many
      end
    end

    context 'Customerモデルとの関係' do
      it '1:Nとなっている' do
        expect(Room.reflect_on_association(:customers).macro).to eq :has_many
      end
    end
  end
end