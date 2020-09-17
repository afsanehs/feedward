require 'rails_helper'
require 'faker'

RSpec.describe UsersController, type: :controller do

  describe "GET show" do
    it "assigns @users" do
      user = User.create
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  
    it "renders the show template" do
      get :show
      expect(response).to render_template("show")
    end
  end

end