class AddConfirmableToDevise < ActiveRecord::Migration[6.0]

  def up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_index :users, :confirmation_token, unique: true

    # User.update_all confirmed_at: DateTime.now
  end

end

# https://github.com/heartcombo/devise/wiki/How-To:-Add-:confirmable-to-Usersrails generate devise:views users