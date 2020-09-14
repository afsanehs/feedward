class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def index
    @feedbacks = Feedback.where(sender: current_user)
    @colleagues = User.where(company_id: current_user.company_id)
  end
  def show
    @feedback = Feedback.find(params[:id])
    if @feedback.sender_id != current_user.id && !current_user.is_site_admin && !current_user.is_company_admin
      flash[:error] = "Vous n'avez pas le droit pour accéder à cette page"
      return redirect_to dashboard_path
    end
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
        redirect_to new_feedback_path
        
      end
  end

  # GET users/:id/feedback
  def user_feedbacks
    if !current_user.is_site_admin && !current_user.is_company_admin
      flash[:error] = "Vous n'avez pas de droit pour accéder à cette page."
      return redirect_to dashboard_path
    end
    @user = User.find(params[:id])
    @feedbacks=Feedback.where(sender: @user)
  end

  private
  def post_params
    post_params = params.require(:feedback).permit(:answer_global, :answer_workspace, :answer_missions, :answer_final, :receiver_id, :score_global, :score_workspace, :score_missions)
  end

end
