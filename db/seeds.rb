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
  email: "yyy@yyy",
  password: "yyyyyy"
  )

Customer.create!(
  is_teacher: true,
  username: "Adam",
  last_name: "Sandler",
  first_name: "Adam",
  email: "aaa@aaa",
  password: "aaaaaa"
  )

Customer.create!(
  is_teacher: true,
  username: "Brad",
  last_name: "Pitt",
  first_name: "Brad",
  email: "bbb@bbb",
  password: "bbbbbb"
  )

Customer.create!(
  is_teacher: true,
  username: "Jackie",
  last_name: "Chan",
  first_name: "Jackie",
  email: "jjj@jjj",
  password: "jjjjjj"
  )

Customer.create!(
  is_teacher: false,
  username: "Gnu",
  last_name: "常田",
  first_name: "大希",
  email: "ggg@ggg",
  password: "gggggg"
  )

Customer.create!(
  is_teacher: false,
  username: "Sakana",
  last_name: "山口",
  first_name: "一郎",
  email: "sss@sss",
  password: "ssssss"
  )

Customer.create!(
  is_teacher: false,
  username: "Indigo",
  last_name: "川谷",
  first_name: "絵音",
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