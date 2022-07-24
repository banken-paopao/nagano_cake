# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Customer.create!(
  last_name: "太郎",
  first_name: "田中",
  last_name_kana: "タロウ",
  first_name_kana: "タナカ",
  email: "tanaka@tarou",
  password: "aaaaaa",
  postal_code: "1111111",
  address: "東京",
  telephone_number: "00011112222",
  is_deleted: "false"
)
