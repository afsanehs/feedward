class ApplicationController < ActionController::Base
  # Devise method
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || user_path(current_user.id)
  end
  def after_sign_up_path_for(resource)
    stored_location_for(resource) || request_companies_path
  end

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end


  protect_from_forgery with: :exception

  def access_denied(exception)
    redirect_to root_path
    flash[:error] = "Vous n'avez pas de droit pour accéder à cette page."
  end

end
