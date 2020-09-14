# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Company.destroy_all
User.destroy_all
Feedback.destroy_all

5.times do 
  Company.create(name: Faker::Company.name)
end 

10.times do
  fake_password = "0123456789"
  user = User.create(email: Faker::Internet.email, 
  password: fake_password, password_confirmation: fake_password, 
  company: Company.all.sample)
end

5.times do 
  Feedback.create(
    score_global: rand(1..5),
    answer_global: Faker::Lorem.sentence(word_count: 6),
    score_workspace: rand(1..5),
    answer_workspace: Faker::Lorem.sentence(word_count: 6),
    score_missions: rand(1..5),
    answer_missions: Faker::Lorem.sentence(word_count: 6),
    answer_final: Faker::Lorem.sentence(word_count: 6),
    sender: User.find(75),
    receiver: User.all.sample,
    created_at: "2020-09-17 14:59:49 UTC"
  )
end