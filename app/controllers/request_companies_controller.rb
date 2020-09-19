class RequestCompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user
  
    # GET /request_companies
    def index
      if !current_user.company.nil?
        return redirect_to user_path(current_user.id)
      end
      @user = current_user
      @companies = Company.all
    end
  
     # POST /request_companies
     def create
      if @user.update(company_id: user_params[:company_id])
        flash[:success] = "Une demande de création votre compte a été envoyée à votre manager. Cela prendra 1 ou 2 jours pour avoir l'acceptation!"
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
  def check_company
    #Force user has their company
    if current_user.company.nil?
     flash[:error] = "Il faut que tu complètes ton profil et que tu renseignes une entreprise avant de commencer !"
     return redirect_to request_companies_path
   end 
 end
end
