class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user
  
  def index
    @user = current_user
    @companies = Company.all
  end

  # POST /accounts
  def create
    if @user.update(user_params)
      flash[:success] = "Votre profil a bien été modifié!"
      redirect_to accounts_path
    else
      @user.errors.full_messages.each do |message|
        flash[:error] = message
      end
      render :index
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
