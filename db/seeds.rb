#***********************************************************************************************************************************#
#                                                       Notice                                                                      #
#                                 Before run the rails db:seed, make sure you run rails db:reset                                    #
#                                     Or run with 2 commands: rails db:drop and rails db:reset                                      #
#***********************************************************************************************************************************#

require 'faker'

Company.destroy_all
User.destroy_all
Feedback.destroy_all

3.times do 
  Company.create(name: Faker::Company.name)
end 
puts "Company created!"

20.times do
  fake_password = "0123456789"
  user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: fake_password, password_confirmation: fake_password, is_validated: true, confirmed_at: Time.now)
  user.update(company: Company.all.sample)
end
puts "20 users created!"

#One fake site_admin_user created
fake_password = "0123456789"
site_admin = User.create(first_name: "Site".first_name, last_name: "Admin", email: "site_admin@yopmail.com", password: fake_password, password_confirmation: fake_password, is_site_admin: true, is_validated: true,  confirmed_at: Time.now)
site_admin.update(company: Company.all.first)
puts "Site admin created!"

#One fake company_admin_user created for each company
fake_password = "0123456789"
company_admin_1 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "company_admin_1@yopmail.com", password: fake_password, password_confirmation: fake_password, is_company_admin: true, is_validated: true,  confirmed_at: Time.now)
company_admin_1.update(company: Company.all.first)
company_admin_2 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "company_admin_2@yopmail.com", password: fake_password, password_confirmation: fake_password, is_company_admin: true, is_validated: true,  confirmed_at: Time.now)
company_admin_2.update(company: Company.all[1])
company_admin_3 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "company_admin_3@yopmail.com", password: fake_password, password_confirmation: fake_password, is_company_admin: true, is_validated: true,  confirmed_at: Time.now)
company_admin_3.update(company: Company.all[2])

puts "Company admin created!"
#One fake test_user created for each company
test_user_1 = User.create(first_name: "Jean", last_name: "Dupont", email: "jean_dupont_1@yopmail.com", password: fake_password, password_confirmation: fake_password, company_id: 1, is_validated: true,  confirmed_at: Time.now)
test_user_1.update(company: Company.all[0])
test_user_2 = User.create(first_name: "Jean", last_name: "Dupont", email: "jean_dupont_2@yopmail.com", password: fake_password, password_confirmation: fake_password, company_id: 2, is_validated: true,  confirmed_at: Time.now)
test_user_2.update(company: Company.all[1])
test_user_3 = User.create(first_name: "Jean", last_name: "Dupont", email: "jean_dupont_3@yopmail.com", password: fake_password, password_confirmation: fake_password, company_id: 3, is_validated: true,  confirmed_at: Time.now)
test_user_3.update(company: Company.all[2])
puts "Test users created!"

100.times do 
  feedback = Feedback.new(
    score_global: rand(0..5),
    answer_global: Faker::Lorem.sentence(word_count: 6),
    score_workspace: rand(0..5),
    answer_workspace: Faker::Lorem.sentence(word_count: 6),
    score_missions: rand(0..5),
    answer_missions: Faker::Lorem.sentence(word_count: 6),
    answer_final: Faker::Lorem.sentence(word_count: 6),
    created_at: Faker::Date.between(from: 60.days.ago, to: Date.today)
  )
  feedback.sender = User.where(is_company_admin: nil, is_site_admin: nil).sample
  feedback.receiver = User.where(company_id: feedback.sender.company_id).where(is_company_admin: nil, is_site_admin: nil).sample
  feedback.save
end
puts "100 feedbacks created!"

Activity.create(name: "user_created");
Activity.create(name: "feedback_created");
Activity.create(name: "feedback_updated");

puts "Activities created!"
puts "Done!"