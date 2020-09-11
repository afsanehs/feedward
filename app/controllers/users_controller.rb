class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :dashboard]
  before_action :correct_user, only: [:show,:update_profile,:dashboard]

  def show
    @user = current_user
    @feedbacks_user = Feedback.where(sender_id: @user.id)
  end

  def profile
    @user = current_user
    @companies = Company.all
  end

  def update_profile
    if @user.update(user_params)
      flash[:success] = "Votre profil a bien été modifié!"
      redirect_back(fallback_location: root_path)
    else
      @user.errors.full_messages.each do |message|
        flash[:error] = message
      end
      render :profile
    end
  end

  def dashboard
    @user = current_user
    @feedbacks = Feedback.joins(:sender).where(users:{company_id: current_user.company_id})
    @feedbacks_received = Feedback.where(receiver_id: @user.id)
    @feedbacks_user = Feedback.where(sender_id: @user.id)
    

    @score_global_average = Feedback.average(:score_global).round(2)
    @score_workspace_average = Feedback.average(:score_workspace).round(2)
    @score_missions_average = Feedback.average(:score_missions).round(2)
    @arr = [@score_global_average, @score_workspace_average, @score_missions_average]
    @average_company_score = (@arr.inject(0.0) { |sum, el| sum + el }.to_f / @arr.size).round(2)


    @score_global_average_by_user = @feedback_user.nil? ? 0 :  @feedbacks_user.average(:score_global).round(2)
    @score_workspace_average_by_user = @feedback_user.nil? ? 0 : @feedbacks_user.average(:score_workspace).round(2)
    @score_missions_average_by_user = @feedback_user.nil? ? 0 : @feedbacks_user.average(:score_missions).round(2)

    @arr_by_user = [@score_global_average_by_user, @score_workspace_average_by_user, @score_missions_average_by_user]
    if @score_global_average_by_user == nil && @score_workspace_average_by_user == nil && @score_missions_average_by_user == nil
      @average_company_score_by_user = 0.0
    else
      @average_company_score_by_user = (@arr_by_user.inject(0.0) { |sum, el| sum + el }.to_f / @arr_by_user.size).round(2)
    end

    #calculations for the pie Chart
    @grade_5_by_user = (@feedbacks_user.where(score_global: 5).count + @feedbacks_user.where(score_workspace: 5).count + @feedbacks_user.where(score_missions: 5).count)
    @grade_4_by_user = (@feedbacks_user.where(score_global: 4).count + @feedbacks_user.where(score_workspace: 4).count + @feedbacks_user.where(score_missions: 4).count)
    @grade_3_by_user = (@feedbacks_user.where(score_global: 3).count + @feedbacks_user.where(score_workspace: 3).count + @feedbacks_user.where(score_missions: 3).count)
    @grade_2_by_user = (@feedbacks_user.where(score_global: 2).count + @feedbacks_user.where(score_workspace: 2).count + @feedbacks_user.where(score_missions: 2).count)
    @grade_1_by_user = (@feedbacks_user.where(score_global: 1).count + @feedbacks_user.where(score_workspace: 1).count + @feedbacks_user.where(score_missions: 1).count)
    @grade_0_by_user = (@feedbacks_user.where(score_global: 0).count + @feedbacks_user.where(score_workspace: 0).count + @feedbacks_user.where(score_missions: 0).count)
    @score_colors = {"Note 5" => "#22347A", "Note 4" => "#6558F1", "Note 3" => "#B2ACFA", "Note 2" => "#CE885D", "Note 1" => "#DFB090", "Note 0" => "#F6E8DF"}
    @grades_by_user = {"Note 5" => @grade_5_by_user, "Note 4" => @grade_4_by_user, "Note 3" => @grade_3_by_user, "Note 2" => @grade_2_by_user, "Note 1" => @grade_1_by_user, "Note 0" => @grade_0_by_user}
    @colors = []
    @grades_by_user.each do |score, _|
      @colors << @score_colors[score]
    end
  end

  def dashboard_admin
    @feedbacks = Feedback.all

    @score_global_average = Feedback.average(:score_global).round(2)
    @score_workspace_average = Feedback.average(:score_workspace).round(2)
    @score_missions_average = Feedback.average(:score_missions).round(2)
    @arr = [@score_global_average, @score_workspace_average, @score_missions_average]
    @average_company_score = (@arr.inject(0.0) { |sum, el| sum + el }.to_f / @arr.size).round(2)

    @score_global_average_yesterday = Feedback.where("created_at <= 'tomorrow'").average(:score_global)
    @score_workspace_average_yesterday = Feedback.where("created_at <= 'tomorrow'").average(:score_workspace)
    @score_missions_average_yesterday = Feedback.where("created_at <= 'tomorrow'").average(:score_missions)
    @arr_yesterday = [@score_global_average_yesterday, @score_workspace_average_yesterday, @score_missions_average_yesterday]
    @average_company_score_yesterday = (@arr_yesterday.inject(0.0) { |sum, el| sum + el }.to_f / @arr_yesterday.size).round(2)

    @average_company_score_evolution = (100*(@average_company_score - @average_company_score_yesterday) / @average_company_score_yesterday).round(2)
    @score_global_average_evolution = (100*(@score_global_average - @score_global_average_yesterday) / @score_global_average_yesterday).round(2)
    @score_workspace_average_evolution = (100*(@score_workspace_average - @score_workspace_average_yesterday) / @score_workspace_average_yesterday).round(2)
    @score_missions_average_evolution = (100*(@score_missions_average - @score_missions_average_yesterday) / @score_missions_average_yesterday).round(2)

    #calculations for the pie Chart
    @grade_5 = (@feedbacks.where(score_global: 5).count + @feedbacks.where(score_workspace: 5).count + @feedbacks.where(score_missions: 5).count)
    @grade_4 = (@feedbacks.where(score_global: 4).count + @feedbacks.where(score_workspace: 4).count + @feedbacks.where(score_missions: 4).count)
    @grade_3 = (@feedbacks.where(score_global: 3).count + @feedbacks.where(score_workspace: 3).count + @feedbacks.where(score_missions: 3).count)
    @grade_2 = (@feedbacks.where(score_global: 2).count + @feedbacks.where(score_workspace: 2).count + @feedbacks.where(score_missions: 2).count)
    @grade_1 = (@feedbacks.where(score_global: 1).count + @feedbacks.where(score_workspace: 1).count + @feedbacks.where(score_missions: 1).count)
    @grade_0 = (@feedbacks.where(score_global: 0).count + @feedbacks.where(score_workspace: 0).count + @feedbacks.where(score_missions: 0).count)
    @score_colors = {"Note 5" => "#22347A", "Note 4" => "#6558F1", "Note 3" => "#B2ACFA", "Note 2" => "#CE885D", "Note 1" => "#DFB090", "Note 0" => "#F6E8DF"}
    @all_grades = {"Note 5" => @grade_5, "Note 4" => @grade_4, "Note 3" => @grade_3, "Note 2" => @grade_2, "Note 1" => @grade_1, "Note 0" => @grade_0}
    @colors = []
    @all_grades.each do |score, _|
      @colors << @score_colors[score]
    end
  end


  def secret

  end


  private
  def correct_user
    @user = current_user
  end
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :company_id
    )
  end
end
