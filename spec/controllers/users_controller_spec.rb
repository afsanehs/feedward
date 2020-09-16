require 'rails_helper'
require 'faker'

RSpec.describe UsersController, type: :controller do

  describe "GET show" do
    it "assigns @users" do
      fake_password = "0123456789"
      user = User.create(email: Faker::Internet.email, 
        password: fake_password, password_confirmation: fake_password, 
        company: Company.all.sample)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  
    it "renders the show template" do
      get :show
      expect(response).to render_template("show")
    end
  end

end