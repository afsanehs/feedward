class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :account_is_validated


  def index
    @feedbacks = Feedback.where(sender: current_user)
    @colleagues = User.where(company_id: current_user.company_id)
  end

  def show
    @feedback = Feedback.find(params[:id])
    if @feedback.sender_id != current_user.id  && !current_user.is_company_admin
      flash[:error] = "Vous n'avez pas le droit pour accéder à cette page"
      return redirect_to user_path(current_user.id)
    end
    if params[:notification] && params[:is_read]
      @notification = Notification.find(params[:notification])
      @notification.update(is_read: true)
    end
  end

  def new
    if current_user.company == nil
      flash[:error] = "Il faut que tu complètes ton profil et que tu renseignes une entreprise avant de commencer !"
      return redirect_to accounts_path
    end

    # check if user created_feedback
    if user_has_created_feedback_today?
      @feedback = get_feedback_current_user_today
      return redirect_to edit_feedback_path(@feedback)
    end
    @feedback = Feedback.new
    @colleagues = User.where(company_id: current_user.company_id)

  end

  def create
    @user = current_user
    @feedback = Feedback.new(feedback_params)
    @feedback.sender = current_user
      if @feedback.save # try to save in the database @feedback
        flash[:success] = "Merci pour votre feedback!"
        redirect_to feedback_path(@feedback.id)
      else
        @feedback.errors.full_messages.each do |message|
          flash[:error] = message
        end
        render :new
      end
  end

  def edit
    @feedback = get_feedback_current_user_today
    if @feedback.id.to_s != params[:id].to_s
      flash[:error] = "Vous pouvez seulement modifier votre feedback aujourd'hui."
      return redirect_to user_path(current_user.id)
    end
    @colleagues = User.where(company_id: current_user.company_id)
    @collegue_id = @feedback.receiver_id
  end 

  def update
    @feedback = Feedback.find(params[:id])
    @colleagues = User.where(company_id: current_user.company_id)
    if @feedback.update(feedback_params)
      flash[:success] = "Votre feedback a été mise à jour."
      redirect_to feedback_path(@feedback)
    else
      @feedback.errors.full_messages.each do |message|
        flash[:error] = message
      end
      render :edit
    end
  end 


  private
  def feedback_params
    params.require(:feedback).permit(
      :answer_global, 
      :answer_workspace, 
      :answer_missions, 
      :answer_final,
      :receiver_id, 
      :score_global, 
      :score_workspace,
      :score_missions
    )
  end
  def account_is_validated
    if !current_user.is_validated  && !current_user.is_company_admin
      flash[:error] = "Votre compte n'est pas encore vérifié. Merci de contacter votre manager pour résoudre ce problème."
      return redirect_to accounts_path
    end
  end
  def is_super_admin?
    return current_user.is_site_admin
  end

  def get_feedback_current_user_today
    return  Feedback.find_by(sender_id: current_user.id,created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
  
  def user_has_created_feedback_today?
    feedback = get_feedback_current_user_today
    return !feedback.nil?
  end


end
