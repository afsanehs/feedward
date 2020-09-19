class RequestUsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user  = User.find(params[:id])
    if params[:notification] && params[:is_read]
      @notification = Notification.find(params[:notification])
      @notification.update(is_read: true)
    end
  end

end
