require 'rails_helper'
require 'faker'

RSpec.describe Feedback, type: :model do

  before(:each) do 
    fake_password = "0123456789"
    @user1 = User.create(email: Faker::Internet.email, 
      password: fake_password, password_confirmation: fake_password, 
      company: Company.all.sample)
    @user2 = User.create(email: Faker::Internet.email, 
      password: fake_password, password_confirmation: fake_password, 
      company: Company.all.sample)
    @feedback = Feedback.create(
      score_global: rand(1..5),
      answer_global: Faker::Lorem.sentence(word_count: 6),
      score_workspace: rand(1..5),
      answer_workspace: Faker::Lorem.sentence(word_count: 6),
      score_missions: rand(1..5),
      answer_missions: Faker::Lorem.sentence(word_count: 6),
      answer_final: Faker::Lorem.sentence(word_count: 6),
      sender: @user1,
      receiver: @user2
    )
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@feedback).to be_a(Feedback)
      expect(@feedback).to be_valid
    end

    describe "#score_global" do
      it "should not be valid without a global score" do
        bad_feedback = Feedback.create(
          score_global: 20,
          answer_global: Faker::Lorem.sentence(word_count: 6),
          score_workspace: rand(1..5),
          answer_workspace: Faker::Lorem.sentence(word_count: 6),
          score_missions: rand(1..5),
          answer_missions: Faker::Lorem.sentence(word_count: 6),
          answer_final: Faker::Lorem.sentence(word_count: 6),
          sender: User.all.sample,
          receiver: User.all.sample
        )
        expect(bad_feedback).not_to be_valid 
        expect(bad_feedback.errors.include?(:score_global)).to eq(true)
      end
    end

    describe "#answer_global" do
      it "should not be valid without a global score below 3 and no global answer" do
        bad_feedback = Feedback.create(
          score_global: 0,
          score_workspace: rand(1..5),
          answer_workspace: Faker::Lorem.sentence(word_count: 6),
          score_missions: rand(1..5),
          answer_missions: Faker::Lorem.sentence(word_count: 6),
          answer_final: Faker::Lorem.sentence(word_count: 6),
          sender: User.all.sample,
          receiver: User.all.sample
        )
        expect(bad_feedback).not_to be_valid
        expect(bad_feedback.errors.include?(:answer_global)).to eq(true)
      end
    end

    describe "global score" do
      it "should not be above 5" do
        bad_feedback = Feedback.create(
          score_global: 20,
          answer_global: Faker::Lorem.sentence(word_count: 6),
          score_workspace: rand(1..5),
          answer_workspace: Faker::Lorem.sentence(word_count: 6),
          score_missions: rand(1..5),
          answer_missions: Faker::Lorem.sentence(word_count: 6),
          answer_final: Faker::Lorem.sentence(word_count: 6),
          sender: User.all.sample,
          receiver: User.all.sample
        )
        expect(bad_feedback).not_to be_valid
        expect(bad_feedback.errors.include?(:score_global)).to eq(true)
      end
    end

  end

  context "public instance methods" do

    describe "#answer_final" do

      it "should return a string" do
        expect(@feedback.answer_final).to be_a(String)
      end

    end

  end

end