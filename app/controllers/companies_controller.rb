class CompaniesController < ApplicationController

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
      redirect_to user_path(current_user.id)
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
