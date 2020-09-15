class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  def index
    @notifications = Notification.joins(:user).where(users: {company_id: current_user.company_id})
  end
  
  def update
    if params[:id_read]
      @notification.update(is_read: true)
      puts "click un read"
      respond_to do |format|
        format.html{}
        format.js{}
      end
  
    end
  end

  private
  def set_notification
    @notification = Notification.find(params[:id])
  end

 
end
