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
      flash[:success] = "Update user profile succesfully!"
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
    @feedbacks = Feedback.all
    @feedbacks_received = Feedback.where(receiver_id: @user.id)
    @feedbacks_user = Feedback.where(sender_id: @user.id)
    @score_global_average = Feedback.average(:score_global)
    @score_workspace_average = Feedback.average(:score_workspace)
    @score_missions_average = Feedback.average(:score_missions)
    @arr = [@score_global_average, @score_workspace_average, @score_missions_average]
    @average_company_score = (@arr.inject(0.0) { |sum, el| sum + el }.to_f / @arr.size).round(2)


    @score_global_average_by_user = @feedbacks_user.average(:score_global)
    @score_workspace_average_by_user = @feedbacks_user.average(:score_workspace)
    @score_missions_average_by_user = @feedbacks_user.average(:score_missions)
    @arr_by_user = [@score_global_average_by_user, @score_workspace_average_by_user, @score_missions_average_by_user]
    if @score_global_average_by_user == nil && @score_workspace_average_by_user == nil && @score_missions_average_by_user == nil
      @average_company_score_by_user = 0.0
    else
      @average_company_score_by_user = (@arr_by_user.inject(0.0) { |sum, el| sum + el }.to_f / @arr_by_user.size).round(2)
    end
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
