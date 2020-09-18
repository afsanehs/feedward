class AddColumToFeedbacks < ActiveRecord::Migration[6.0]
  def up
    add_column :feedbacks, :score_average, :float
  end
  def down
    remove_column :feedbacks, :score_average, :float
  end
end
