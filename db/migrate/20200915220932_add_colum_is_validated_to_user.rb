class AddColumIsValidatedToUser < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :is_validated, :boolean
  end
  def down
    remove_column :users, :is_validated, :boolean
  end
end
