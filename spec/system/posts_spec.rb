require 'rails_helper'

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
  describe 'ヘッダーのテスト' do
		context '表示の確認' do
			it 'ウェルカムメッセージが表示される' do
	    	expect(page).to have_content 'Welcome aboard customer.username'
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
end

describe '投稿一覧のテスト' do
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
		context '投稿一覧の表示の確認' do
		  it '投稿者のusernameが表示される' do
	    	expect(page).to have_content post.customer.username
		  end
		  it '投稿者のimage画像が表示される' do
		  	expect(page).to have_content post.customer.image_id
		  end
		  it 'つぶやきの本文が表示される' do
		  	expect(page).to have_content post.body
		  end
		  it 'つぶやきへのレビュー評価が表示される' do
		  	expect(page).to have_content post.reviews.average(:rate)
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
		  	expect(page).to eq('/posts')
		  end
		  it '投稿に失敗する' do
		  	click_button '英語でつぶやく'
		  	expect(page).to have_content 'つぶやき本文を入力してください'
		  	expect(current_path).to eq('/posts')
		  end
		end
  end

  describe '編集のテスト' do
  	context '自分の投稿の編集画面への遷移' do
  	  it '遷移できる' do
	  		visit edit_post_path(post)
	  		expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
	  	end
	  end
		context '他人の投稿の編集画面への遷移' do
		  it '遷移できない' do
		    visit edit_post_path(post2)
		    expect(current_path).to eq('/posts')
		  end
		end
		context '表示の確認' do
			before do
				visit edit_post_path(post)
			end
			it 'Editing postと表示される' do
				expect(page).to have_content('Editing post')
			end
			it 'title編集フォームが表示される' do
				expect(page).to have_field 'post[title]', with: post.title
			end
			it 'opinion編集フォームが表示される' do
				expect(page).to have_field 'post[body]', with: post.body
			end
			it 'Showリンクが表示される' do
				expect(page).to have_link 'Show', href: post_path(post)
			end
			it 'Backリンクが表示される' do
				expect(page).to have_link 'Back', href: posts_path
			end
		end
		context 'フォームの確認' do
			it '編集に成功する' do
				visit edit_post_path(post)
				click_button 'Update post'
				expect(page).to have_content 'successfully'
				expect(current_path).to eq '/posts/' + post.id.to_s
			end
			it '編集に失敗する' do
				visit edit_post_path(post)
				fill_in 'post[title]', with: ''
				click_button 'Update post'
				expect(page).to have_content 'error'
				expect(current_path).to eq '/posts/' + post.id.to_s
			end
		end
	end

  describe '一覧画面のテスト' do
  	before do
  		visit posts_path
  	end
  	context '表示の確認' do
  		it 'postsと表示される' do
  			expect(page).to have_content 'posts'
  		end
  		it '自分と他人の画像のリンク先が正しい' do
  			expect(page).to have_link '', href: customer_path(post.customer)
  			expect(page).to have_link '', href: customer_path(post2.customer)
  		end
  		it '自分と他人のタイトルのリンク先が正しい' do
  			expect(page).to have_link post.title, href: post_path(post)
  			expect(page).to have_link post2.title, href: post_path(post2)
  		end
  		it '自分と他人のオピニオンが表示される' do
  			expect(page).to have_content post.body
  			expect(page).to have_content post2.body
  		end
  	end
  end

  describe '詳細画面のテスト' do
  	context '自分・他人共通の投稿詳細画面の表示を確認' do
  		it 'post detailと表示される' do
  			visit post_path(post)
  			expect(page).to have_content 'post detail'
  		end
  		it 'ユーザー画像・名前のリンク先が正しい' do
  			visit post_path(post)
  			expect(page).to have_link post.customer.name, href: customer_path(post.customer)
  		end
  		it '投稿のtitleが表示される' do
  			visit post_path(post)
  			expect(page).to have_content post.title
  		end
  		it '投稿のopinionが表示される' do
  			visit post_path(post)
  			expect(page).to have_content post.body
  		end
  	end
  	context '自分の投稿詳細画面の表示を確認' do
  		it '投稿の編集リンクが表示される' do
  			visit post_path post
  			expect(page).to have_link 'Edit', href: edit_post_path(post)
  		end
  		it '投稿の削除リンクが表示される' do
  			visit post_path post
  			expect(page).to have_link 'Destroy', href: post_path(post)
  		end
  	end
  	context '他人の投稿詳細画面の表示を確認' do
  		it '投稿の編集リンクが表示されない' do
  			visit post_path(post2)
  			expect(page).to have_no_link 'Edit', href: edit_post_path(post2)
  		end
  		it '投稿の削除リンクが表示されない' do
  			visit post_path(post2)
  			expect(page).to have_no_link 'Destroy', href: post_path(post2)
  		end
  	end
  end
