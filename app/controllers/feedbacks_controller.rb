class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def show
    @feedback = Feedback.find(params[:id])
  end

end
