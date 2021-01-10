require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe '投稿一覧ページ' do
    context "投稿一覧ページが正しく表示される" do
      before do
        get root_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end
end