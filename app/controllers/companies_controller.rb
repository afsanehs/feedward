class CompaniesController < ApplicationController

  def company_user_new
    @user = User.new
  end 

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
      render :new
    end  
  end 

  def new
    @company = Company.new
  end

  def create
    puts "$" *30
    puts company_params
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
    end
  end 

  private
  def company_params
    params[:company].permit(
      :name
    )
  end 

end
