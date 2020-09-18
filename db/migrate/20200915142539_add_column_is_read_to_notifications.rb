class AddColumnIsReadToNotifications < ActiveRecord::Migration[6.0]
  def up
    add_column :notifications, :is_read, :boolean
  end
  def down
    remove_column :notifications, :is_read, :boolean
  end
end
