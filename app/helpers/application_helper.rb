module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end
  def alert_class(score)
    score >= 3 ? "text-indigo" : "text-alert"
  end
  def is_read_class(notification)
    return notification.is_read ? "is-read" : ""
  end
  def is_read_disabled_class(notification)
    return notification.is_read ? "disable-read" : "text-success"
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

  def all_notifications
    if user_signed_in?
      return Notification.joins(:user).where(users:{company_id: current_user.company_id}).order(:created_at).reverse
    end
    return []
  end
  def all_notifications_unread
    if user_signed_in?
      return Notification.joins(:user).where(users:{company_id: current_user.company_id}).where(is_read: false).order(:created_at).reverse
    end
    return []
  end
  def count_notifications_unread
    return all_notifications_unread.count
  end


  def get_time(time_utc)
    return time_utc.strftime("%Y-%m-%d %k:%M:%S")
  end

  def get_time_verbose(time_utc)
    return l(time_utc, format: '%d/%m/%Y - à %k:%M')
  end
  def get_date(time_utc)
    return l(time_utc, format: '%d/%m/%Y')
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
