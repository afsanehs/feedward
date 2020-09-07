class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.integer :score_global
      t.text :answer_global
      t.integer :score_workspace
      t.text :answer_workspace
      t.integer :score_missions
      t.text :answer_missions
      t.text :answer_final
      t.belongs_to :sender, index: true
      t.belongs_to :receiver, index: true

      t.timestamps
    end
  end
end
