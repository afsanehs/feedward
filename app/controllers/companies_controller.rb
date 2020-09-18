class CompaniesController < ApplicationController
  # GET /company_user_new
  def company_user_new
    @user = User.new
  end 

  #POST /company_user_new
  def company_user_create 
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

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @user = User.last
    if @company.save # try to save in the database @feedback
      @user.update(company: @company)
      flash[:success] = "Votre entreprise a bien été créé"
      sign_in(@user)
      redirect_to dashboard_admin_path
    else 
      @company.errors.full_messages.each do |message|
        flash[:error] = message
      end
      @user.destroy
      render :new
    end
  end 

  private
  def company_params
    params[:company].permit(
      :name
    )
  end 

end
