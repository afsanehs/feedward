class CompanyUsersController < ApplicationController

  # GET /company_users/new
  def new
    @user = User.new
  end 

  #POST /company_users
  def create 
    @user = User.new(
      email: params[:email],
      password: params[:password], 
      password_confirmation: params[:password_confirmation],
      is_validated: true,
      is_company_admin: true,
      confirmed_at: Time.now
      )
    
    if @user.save
      redirect_to new_company_path
    else
      @user.errors.full_messages.each do |message|
        flash[:error] = message
      end
      render :company_user_new
    end  
  end 

end
