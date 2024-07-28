# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: 'admin@admin',
   password: 'aaaaaa'
)

users_attributes = [
      { name: "user1",
        email: "user1@test.com",
        password: "password",
        introduction: "よろしくね！",
        is_celebrity: true },
      { name: "user2",
        email: "user2@test.com",
        password: "password",
        introduction: "よい一日を！"},
      { name: "user3",
        email: "user3@test.com",
        password: "password",
        introduction: "よろしく！" }
  ]

