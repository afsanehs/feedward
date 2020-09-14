require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do

  before(:each) do 
    fake_password = "0123456789"
    @user = User.create(email: Faker::Internet.email, 
    password: fake_password, password_confirmation: fake_password)
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@user).to be_a(User)
      expect(@user).to be_valid
    end

    describe "#first_name" do
      it "should not be valid without email" do
        fake_password = "0123456789"
        bad_user = User.create(password: fake_password, password_confirmation: fake_password)
        expect(bad_user).not_to be_valid 
        expect(bad_user.errors.include?(:email)).to eq(true)
      end
    end

    describe "#last_name" do
      it "should not be valid without password" do
        bad_user = User.create(email: Faker::Internet.email)
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:password)).to eq(true)
      end
    end

    describe "password" do
      it "should not be lower that 8 characters" do
        fake_password = "123"
        invalid_user = User.create(email: Faker::Internet.email, 
          password: fake_password, password_confirmation: fake_password)
        expect(invalid_user).not_to be_valid
        expect(invalid_user.errors.include?(:password)).to eq(true)
      end
    end

  end

  context "public instance methods" do

    describe "#email" do

      it "should return a string" do
        expect(@user.email).to be_a(String)
      end

    end

  end

end