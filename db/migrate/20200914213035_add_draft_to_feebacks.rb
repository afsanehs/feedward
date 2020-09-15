class AddDraftToFeebacks < ActiveRecord::Migration[6.0]
  def change
    add_column :feedbacks, :draft, :boolean
  end
end
