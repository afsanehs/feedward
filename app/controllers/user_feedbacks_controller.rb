class UserFeedbacksController < ApplicationController
  before_action :authenticate_user!

  # GET users/:id:/user_feedbacks
  def index
    puts "--------------------"
    puts params
    if current_user.is_company_admin || current_user.id.to_s == params[:user_id].to_s
      @user = User.find(params[:user_id])
      return @feedbacks=Feedback.where(sender: @user)
    end
    flash[:error] = "Vous n'avez pas de droit pour accéder à cette page."
    redirect_to user_path(current_user.id)
  end

end
