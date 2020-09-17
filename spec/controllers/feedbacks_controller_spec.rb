require 'rails_helper'
require 'faker'

RSpec.describe FeedbacksController, type: :controller do

  describe "GET show" do
    it "assigns @feedbacks" do
      feedback = Feedback.create(
        score_global: rand(1..5),
        answer_global: Faker::Lorem.sentence(word_count: 6),
        score_workspace: rand(1..5),
        answer_workspace: Faker::Lorem.sentence(word_count: 6),
        score_missions: rand(1..5),
        answer_missions: Faker::Lorem.sentence(word_count: 6),
        answer_final: Faker::Lorem.sentence(word_count: 6),
        sender: User.all.sample,
        receiver: User.all.sample
      )
      get :show, params: { id: feedback.id }
      expect(assigns(:feedbacks)).to eq([feedback])
    end
  
    it "renders the show template" do
      get :show
      expect(response).to render_template("show")
    end
  end

end