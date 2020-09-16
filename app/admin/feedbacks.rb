ActiveAdmin.register Feedback do
  permit_params :score_global, :answer_global, :score_workspace, :answer_workspace, :score_missions, :answer_missions, :answer_final, :sender_id, :receiver_id, :score_average, :draft

  index do
    selectable_column
    id_column
    column :score_global
    column :score_workspace
    column :score_missions
    column :answer_final
    column :sender_id
    column :receiver_id
    column :score_average
    column :draft
    actions
  end

  filter :score_global
  filter :score_workspace
  filter :score_missions
  filter :answer_final
  filter :sender_id
  filter :receiver_id
  filter :draft

end
