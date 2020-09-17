class CompaniesController < ApplicationController
  
  def new
    @company = Company.new
    @user = User.new
    @amount = 3000
  end

  def create
    create_company
  end 

  private
  def company_params
    params[:company].permit(
      :name
    )
  end 

  def create_company
    @company = Company.new(company_params)
    if @company.save # try to save in the database @feedback
      @user = User.new(
        first_name: params[:first_name], 
        last_name: params[:last_name], 
        email: params[:email],
        password: params[:password], 
        password_confirmation: params[:password_confirmation],
        is_validated: true,
        is_company_admin: true,
        confirmed_at: Time.now
        )
      if @user.save
        @user.update(company: @company)
        flash[:success] = "Votre entreprise a bien été créé"
        sign_in(@user)
        redirect_to dashboard_admin_path
      else
        @user.errors.full_messages.each do |message|
          flash[:error] = message
        end
        @company.destroy
        render :new
      end 

    else
      @company.errors.full_messages.each do |message|
        flash[:error] = message
      end
      render :new
    end
  end

end
