module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end
  def flash_class(level)
    case level
        when "notice"
          return "alert alert-info"
        when "success"
          return "alert alert-success"
        when "error"
          return "alert alert-danger"
        when "warning"
          return "alert alert-warning"
        when "alert"
          return "alert alert-danger"
    end
  end

  def get_time(time_utc)
    return time_utc.strftime("%Y-%m-%d %k:%M:%S")
  end

  def get_time_verbose(time_utc)
    return l(time_utc, format: '%d/%m/%Y - à %k:%M')
  end

  #----------------------------------#
  # Using devise form in another page
  def resource_name
    :user
  end

  def resource
    @resource ||= current_user
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


end
