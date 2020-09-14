class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end
  def after_sign_up_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  def moon
  cookies[:moon] = {
    value: 'dark mode on'
  }
    if user_signed_in?
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

  def sun
    cookies.delete(:moon)
    if user_signed_in?
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end



end
