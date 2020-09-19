class NotificationAccountsController < ApplicationController
    before_action :authenticate_user!
    before_action :must_be_admin

  
    # PATCH account/validate/:id
    def update
      @user = User.find(params[:id])
      @notification = Notification.find(params[:notification])
      if @user.update(is_validated: true)
          @notification.destroy
          respond_to do |format|
            format.html {
              redirect_to notifications_path
            }
            format.json{head :not_content}
            format.js{ }
          end
      else
          format.html { render :request_company }
          format.json { render json: @user.errors, status: :unprocessable_entity }
          format.js {}
          flash[:error] = @user.errors.full_messages.first
      end
    end


    # DELETE /refuseaccount/:id
    def destroy
      @user = User.find(params[:id])
      @notification = Notification.find(params[:notification])
      @user.destroy
      respond_to do |format|
        format.html {
          redirect_to notifications_path
        }
        format.json{head :not_content}
        format.js{ }
      end
    end

    private
    def must_be_admin
      if !current_user.is_company_admin
        flash[:error] = "Vous n'avez pas de droit pour accéder à cette page."
        return redirect_back(fallback_location: user_path(current_user.id) )
      end
    end


end
