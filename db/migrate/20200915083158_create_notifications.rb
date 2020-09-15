class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.belongs_to :activity, index: true
      t.belongs_to :user, index: true
      t.belongs_to :feedback, index: true

      t.timestamps
    end
  end
end
