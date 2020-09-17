class CompaniesController < ApplicationController
  
  def new
    @company = Company.new
    @user = User.new
    @amount = 3000
  end

  def create
    @amount = 3000*100
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount.to_i,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })

    # create_company

    rescue Stripe::CardError => e
      flash[:error] = e.message
      render :new
   
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
        redirect_to dashboard_admin_path   
      else
        @company.destroy
        @company.errors.full_messages.each do |message|
          flash[:error] = message
        end
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
