class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :correct_user, only: [:show,:update_profile]

  def show
    @user = current_user
    @feedbacks_user = Feedback.where(sender_id: @user.id)
  end

  def profile
    @user = current_user
    @companies = Company.all
  end

  def update_profile
    puts "---------------------------------------------"
    puts params
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
