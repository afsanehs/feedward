ActiveAdmin.register Notification do
  permit_params :activity_id, :user_id, :feedback_id, :is_read

end
