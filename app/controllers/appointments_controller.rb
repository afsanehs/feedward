class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :account_is_validated
  before_action :must_be_admin

  def index
    @appointments = Appointment.where(employer: current_user)
  end

  def show
    @appointment = Appointment.find(params[:id])
    if @appointment.employer_id != current_user.id
      flash[:error] = "Vous n'avez pas le droit pour accéder à cette page."
      return redirect_to dashboard_admin_path
    end
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.employer = current_user
    if @appointment.save
      flash[:success] = "Votre événement a été créé!"
      redirect_to appointment_path(@appointment.id)
    else
      @appointment.errors.full_messages.each do |message|
        flash[:error] = message
      end
      redirect_to new_appointment_path
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
    if @appointment.employer.id != current_user.id
      flash[:error] = "Vous n'avez pas le droit pour accéder à cette page."
      return redirect_to dashboard_admin_path
    end
  end 

  def update
    if @appointment.update(appointment_params)
      flash[:success] = "Votre événement a été modifié!"
      redirect_to appointment_path(@appointment.id)
    else
      @appointment.errors.full_messages.each do |message|
        flash[:error] = message
      end
      redirect_to edit_appointment_path(@appointment.id)
    end
  end 

  def destroy
    @appointment = Appointment.find(params[:id])
    if @appointment.employer.id != current_user.id
      flash[:error] = "Vous n'avez pas le droit pour accéder à cette page."
      return redirect_to dashboard_admin_path
    else
      @appointment.destroy
      redirect_to appointments_path
    end
  end 

  private
  def appointment_params
    appointment_params = params.require(:appointment).permit(:title, :description, :start_date, :end_date, :employee_id)
  end

  def account_is_validated
    if !current_user.is_validated 
      flash[:error] = "Votre compte n'est pas encore vérifié. Merci de contacter votre manager pour résoudre ce problème."
      return redirect_to profile_path
    end
  end

  def must_be_admin
    if !current_user.is_company_admin
      flash[:error] = "Vous n'avez pas de droit pour accéder à cette page."
      return redirect_back(fallback_location: dashboard_path )
    end
  end

end
