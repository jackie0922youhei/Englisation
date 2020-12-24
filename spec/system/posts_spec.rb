require 'rails_helper'

describe '投稿一覧のテスト' do
  let(:customer) { create(:customer) }
  let!(:customer2) { create(:customer) }
  let!(:post) { create(:post, customer: customer) }
  let!(:review) { create(:review, customer: customer, post: post)}
  before do
  	visit new_customer_session_path
  	fill_in 'customer[username]', with: customer.username
  	fill_in 'customer[password]', with: customer.password
  	click_button 'ログイン'
  end
  describe '表示項目のテスト' do
		context '投稿一覧の表示の確認' do
		  it '投稿者のusernameが表示される' do
	    	expect(page).to have_content post.customer.username
		  end
		  it '投稿者のimage画像が表示される' do
		  	expect(within("#post_box") {first("img")}).to be_truthy
		  end
		  it 'つぶやきの本文が表示される' do
		  	expect(page).to have_content post.body
		  end
		  it 'つぶやきへのレビュー評価が表示される' do
		  	expect(page.has_selector?("#average-review-rate1[data-score='#{post.reviews.average(:rate).round(2)}']")).to be_truthy
		  end
		  it 'つぶやきの参照元が表示される' do
		  	expect(page).to have_content post.reference
		  end
		  it 'つぶやきの投稿日時が表示される' do
		  	expect(page).to have_content post.created_at.strftime("%Y/%m/%d %H:%M")
		  end
		  it 'つぶやきへのいいねの件数が表示される' do
		  	expect(page).to have_content post.favorites.count
		  end
		  it 'つぶやきへのコメント数が表示される' do
		  	expect(page).to have_content post.comments.count
		  end
		end
	end
end

describe '投稿のテスト' do
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
	context '投稿の確認' do
	  it '投稿に成功する' do
	  	fill_in 'post[body]', with: Faker::Lorem.characters(number:40)
	  	fill_in 'post[reference]', with: Faker::Lorem.characters(number:20)
	  	click_button '英語でつぶやく'
	  	expect(current_path).to eq('/')
	  end
	  it '投稿に失敗する' do
	  	click_button '英語でつぶやく'
	  	expect(page).to have_content 'つぶやき本文を入力してください'
	  	expect(current_path).to eq('/')
	  end
	end
end

 describe '詳細画面のテスト' do
 	let(:customer) { create(:customer, is_teacher: is_teacher) }
 	let!(:customer2) { create(:customer) }
 	let!(:post) { create(:post, customer: customer) }
 	let!(:post2) { create(:post, customer: customer2) }
 	let(:is_teacher) { false }
 	before do
 		visit new_customer_session_path
 		fill_in 'customer[username]', with: customer.username
 		fill_in 'customer[password]', with: customer.password
 		click_button 'ログイン'
 	end
 	context '自分の投稿の詳細画面への遷移' do
 		before do
 			visit post_path(post)
 		end
 	  it '遷移できる' do
  		expect(current_path).to eq('/posts/' + post.id.to_s )
  	end
  end
	context '表示の確認' do
		before do
	 	  visit post_path(post)
	 	end
		context '一般ユーザとしてログインした場合' do
			it '投稿者のusernameが表示される' do
				expect(page).to have_content post.customer.username
			end
			it '投稿者のimage画像が表示される' do
				expect(within(".post_show_left") {first("img")}).to be_truthy
			end
			it 'つぶやきの本文が表示される' do
				expect(page).to have_content post.body
			end
			it 'つぶやきへのレビュー評価が表示される' do
				expect(page.has_selector?("#average-review-rate1[data-score='#{post.reviews.average(:rate).round(2)}']")).to be_truthy
			end
			it 'つぶやきの参照元が表示される' do
				expect(page).to have_content post.reference
			end
			it 'つぶやきの投稿日時が表示される' do
				expect(page).to have_content post.created_at.strftime("%Y/%m/%d %H:%M")
			end
			it 'つぶやきへのいいねの件数が表示される' do
				expect(page).to have_content post.favorites.count
			end
			it 'つぶやきへのコメント数が表示される' do
				expect(page).to have_content post.comments.count
			end
			it 'コメントフォームが表示される' do
				expect(page).to have_field 'comment[body]'
			end
			it 'レビューフォームが表示されない' do
				expect(page).to_not have_field 'review[body]'
			end
		end
		context '講師でログインした場合' do
			let(:is_teacher) { true }
			it 'レビューフォームが表示される' do
				expect(page).to have_field 'review[body]'
			end
		end
	end
end

  describe '一覧画面のテスト' do
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
	end
