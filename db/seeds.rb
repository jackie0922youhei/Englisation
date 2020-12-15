# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Admin.find_by(username: "admin1") == nil
Admin.create!(
  username: "admin1",
  email: "a@aa",
  password: "admin1"
  )
end

Customer.create!(
  id: 1,
  is_teacher: false,
  username: "Yohei",
  last_name: "西尾",
  first_name: "洋平",
  last_name_kana: "ニシオ",
  first_name_kana: "ヨウヘイ",
  telephone_number: "09011110000",
  email: "yyy@yyy",
  password: "yyyyyy"
  )

Customer.create!(
  is_teacher: true,
  username: "Adam",
  last_name: "Sandler",
  first_name: "Adam",
  last_name_kana: "サンドラー",
  first_name_kana: "アダム",
  telephone_number: "09011112222",
  email: "aaa@aaa",
  password: "aaaaaa"
  )

Customer.create!(
  is_teacher: true,
  username: "Brad",
  last_name: "Pitt",
  first_name: "Brad",
  last_name_kana: "ピット",
  first_name_kana: "ブラッド",
  telephone_number: "09011113333",
  email: "bbb@bbb",
  password: "bbbbbb"
  )

Customer.create!(
  is_teacher: true,
  username: "Jackie",
  last_name: "Chan",
  first_name: "Jackie",
  last_name_kana: "チェン",
  first_name_kana: "ジャッキー",
  telephone_number: "09011114444",
  email: "jjj@jjj",
  password: "jjjjjj"
  )

Customer.create!(
  is_teacher: false,
  username: "Gnu",
  last_name: "常田",
  first_name: "大希",
  last_name_kana: "ツネタ",
  first_name_kana: "ダイキ",
  telephone_number: "09011116666",
  email: "ggg@ggg",
  password: "gggggg"
  )

Customer.create!(
  is_teacher: false,
  username: "Sakana",
  last_name: "山口",
  first_name: "一郎",
  last_name_kana: "ヤマグチ",
  first_name_kana: "イチロウ",
  telephone_number: "09011115555",
  email: "sss@sss",
  password: "ssssss"
  )

Customer.create!(
  is_teacher: false,
  username: "Indigo",
  last_name: "川谷",
  first_name: "絵音",
  last_name_kana: "カワタニ",
  first_name_kana: "エノン",
  telephone_number: "09011117777",
  email: "iii@iii",
  password: "iiiiii"
  )

Post.create!(
  body: "I never meant to hurt you. I never meant to make you cry.",
  reference: "Cleanin' Out My Closet/Eminem",
  tag_list_id: "Music, Song",
  customer_id: "1"
)

Post.create!(
  body: "We are the world. We are the children.",
  reference: "We Are The World",
  tag_list_id: "Music, Song",
  customer_id: "1"
)