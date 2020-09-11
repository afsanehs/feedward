class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  def show
    @feedback = Feedback.find(params[:id])
  end

  def new
    if current_user.company == nil
      redirect_to profile_path
      flash[:error] = "Il faut que tu complètes ton profil et que tu renseignes une entreprise avant de commencer !"
    else
      @feedback = Feedback.new
      @colleagues = User.where(company_id: current_user.company_id)
    end 
  end

  def create
    @user = current_user
    @feedback = Feedback.new(post_params)
    @feedback.sender = current_user
      if @feedback.save # try to save in the database @feedback
        flash[:success] = "Votre feedback a été créé!"
        redirect_to feedback_path(@feedback.id)
      else
        @feedback.errors.full_messages.each do |message|
          flash[:error] = message
        end
        render :new
        
      end
  end

  private
  def post_params
    post_params = params.require(:feedback).permit(:answer_global, :answer_workspace, :answer_missions, :answer_final, :receiver_id, :score_global, :score_workspace, :score_missions)
  end

end
