class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :must_be_admin
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  def index
    @notifications = Notification.joins(:user).where(users: {company_id: current_user.company_id}).order(:created_at).reverse
  end
  
  def update
    if params[:is_read]
      @notification.update(is_read: true)
      respond_to do |format|
        format.html{}
        format.js{ flash[:success] = "Feedback marqué comme lu." }
      end
    end

  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html {
        redirect_to notifications_path
      }
      format.json{head :not_content}
      format.js{ flash[:success] = "Feedback archivé avec succès." }
    end
  end

  # DELETE /refuseaccount/:id
  def refuse_account
    @user = User.find(params[:id])
    @notification = Notification.find(params[:notification])
    @user.destroy
    respond_to do |format|
      format.html {
        redirect_to notifications_path
      }
      format.json{head :not_content}
      format.js{ flash[:success] = "Refuser un compte avec succès." }
    end
  end

  # PATCH account/validate/:id
  def validate_account
  @user = User.find(params[:id])
  @notification = Notification.find(params[:notification])
  if @user.update(is_validated: true)
    @notification.destroy
    respond_to do |format|
      format.html {
        redirect_to notifications_path
      }
      format.json{head :not_content}
      format.js{ flash[:success] = "Refuser un compte avec succès." }
    end
    flash[:success] = "Valider un compte avec succès!"
  else
    format.html { render :request_company }
    format.json { render json: @user.errors, status: :unprocessable_entity }
    format.js {}
    flash[:error] = @user.errors.full_messages.first
  end
  end

  private
  def set_notification
    @notification = Notification.find(params[:id])
  end
  def must_be_admin
    if !current_user.is_company_admin
      flash[:error] = "Vous n'avez pas de droit pour accéder à cette page."
      return redirect_back(fallback_location: dashboard_path )
    end
  end
  def is_super_admin?
    return current_user.is_site_admin
  end

 
end
