module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # ApplicationCable::Connectionクラスを使って、認証情報を定義
    # identified_byはコネクションを識別するキーとなるもの
    identified_by :current_customer

    def connect
      # connectメソッドはコネクションの接続時に呼ばれるメソッド
      self.current_customer = find_verified_customer
    end

    protected
    def find_verified_customer
      # コネクションの識別キーとして、ログイン時に設定したCookieからcustomer_idを取り出している
      if verified_customer = Customer.find_by(id: cookies.signed['customer.id'])
        verified_customer
      else
        reject_unauthorized_connection
      end
    end

  end
end
