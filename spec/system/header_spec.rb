require 'rails_helper'

describe 'ヘッダーのテスト' do
  describe 'ログインしていない場合' do
    before do
      visit root_path
    end
    context 'ヘッダーのリンクを確認' do
      subject { current_path }
      it 'Home画面に遷移する' do
        home_link = find_all('a')[0].native.inner_text
        home_link = home_link.delete(' ')
        home_link.gsub!(/\n/, '')
        click_link home_link
        is_expected.to eq(root_path)
      end
      it 'About画面に遷移する' do
        about_link = find_all('a')[1].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq('/homes/about')
      end
      it '新規登録画面に遷移する' do
        signup_link = find_all('a')[2].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link
        is_expected.to eq(new_customer_registration_path)
      end
      it 'ログイン画面に遷移する' do
        login_link = find_all('a')[3].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq(new_customer_session_path)
      end
    end
  end

  describe 'ログインしている場合' do
    let(:customer) { create(:customer) }
    let!(:customer2) { create(:customer) }
    let!(:post) { create(:post, customer: customer) }
    let!(:post2) { create(:post, customer: customer2) }
    before do
    	visit new_customer_session_path
    	fill_in 'customer[username]', with: customer.username
    	fill_in 'customer[password]', with: customer.password
    	click_button 'ログイン'
    end
    describe 'ヘッダーのテスト' do
	  	context '表示の確認' do
	  	  subject { page }
	  		it 'ウェルカムメッセージが表示される' do
	      	expect(page).to have_content 'Welcome aboard <%= customer.username %>'
	  	  end
	  	  it 'マイページと表示される' do
	      	expect(page).to have_content 'マイページ'
	  	  end
	  	  it 'DMと表示される' do
	  	  	expect(page).to have_content 'DM'
	  	  end
	  	  it 'NOTICEと表示される' do
	  	  	expect(page).to have_content 'NOTICE'
	  	  end
	  	  it 'ログアウトが表示される' do
	  	  	expect(page).to have_content 'ログアウト'
	  	  end
	  	end
	  end

    context 'ヘッダーのリンクを確認' do
      subject { current_path }
      it 'Home画面に遷移する' do
        home_link = find_all('a')[0].native.inner_text
        home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_link
        is_expected.to eq('/')
      end
      it 'logoutする' do
        logout_link = find_all('a')[3].native.inner_text
        logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link logout_link
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
end
