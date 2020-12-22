require 'rails_helper'

describe Customers::PostsController, type: :controller do
  let(:customer) { create(:customer) }
  # customerをcreateし、let内に格納
  describe 'GET #index' do
    before do
      login_customer customer
      # controller_macros.rb内のlogin_customerメソッドを呼び出し
    end
    it "renders the :index template" do
    end
  end
end