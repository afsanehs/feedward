class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  def show
    @feedback = Feedback.find(params[:id])
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @user = current_user
    @feedback = Feedback.new(post_params)
    @feedback.sender_id = current_user.id
      if @feedback.save # try to save in the database @feedback
        redirect_to feedback_path(@feedback.id)
      else
        render :new
      end
    end

  private
  def post_params
    post_params = params.require(:feedback).permit(:answer_global, :answer_workspace, :answer_missions, :answer_final, :receiver_id, :score_global, :score_workspace, :score_missions)
  end
end
