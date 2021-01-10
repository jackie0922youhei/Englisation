require 'rails_helper'

RSpec.describe Customer, type: :model do
  context "ユーザーが正しく保存される" do
    it "全ての項目を入力すれば保存できる" do
      customer = build(:customer)
      expect(customer).to be_valid
    end

    it "usernameがなければ保存できない" do
      customer = build(:customer, username: nil)
      expect(customer.valid?).to eq(false)
      expect(customer.errors[:username]).to include("を入力してください")
    end

    it "last_nameがなければ保存できない" do
      customer = build(:customer, last_name: nil)
      expect(customer.valid?).to eq(false)
      expect(customer.errors[:last_name]).to include("を入力してください")
    end

    it "first_nameがなければ保存できない" do
      customer = build(:customer, first_name: nil)
      expect(customer.valid?).to eq(false)
      expect(customer.errors[:first_name]).to include("を入力してください")
    end

    it "passwordがなければ保存できない" do
      customer = build(:customer, password: nil)
      customer.valid?
      expect(customer.errors[:password]).to include("を入力してください")
    end

    it "password_confirmationとpasswordが一致しなければ保存できない" do
      customer = build(:customer, password_confirmation: "")
      customer.valid?
      expect(customer.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "emailが重複していたら保存できない" do
      customer = build(:customer)
      customer.save
      another_customer = build(:customer, email: customer.email)
      another_customer.valid?
      expect(another_customer.errors[:email]).to include("はすでに存在します")
    end

    it "passwordが5文字以下なら保存できない" do
      customer = build(:customer, password: "00000", password_confirmation: "00000")
      customer.valid?
      expect(customer.errors[:password][0]).to include("は6文字以上で入力してください")
    end

    it "6文字以上のpasswordなら保存できる" do
      customer = build(:customer, password: "000000", password_confirmation: "000000")
      customer.valid?
      expect(customer).to be_valid
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:posts).macro).to eq :has_many
      end
    end

    context 'Reviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Entryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:entries).macro).to eq :has_many
      end
    end

    context 'DirectMessageモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:direct_messages).macro).to eq :has_many
      end
    end

    context 'Roomモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:rooms).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end

    context 'Relationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:active_relationships).macro).to eq :has_many
      end
    end

    context 'Relationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:passive_relationships).macro).to eq :has_many
      end
    end
  end
end