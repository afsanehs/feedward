require 'rails_helper'
require 'faker'

RSpec.describe Company, type: :model do

  before(:each) do 
    @company = Company.create(name: Faker::Company.name)
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@company).to be_a(Company)
      expect(@company).to be_valid
    end

  end

  context "public instance methods" do

    describe "#name" do

      it "should return a string" do
        expect(@company.name).to be_a(String)
      end

    end

  end

end