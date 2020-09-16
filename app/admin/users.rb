ActiveAdmin.register User do
  permit_params :first_name, :last_name, :is_site_admin, :is_company_admin, :company_id, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :is_validated

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :company
    column :email
    column :is_site_admin
    column :is_company_admin
    column :is_validated
    actions
  end

  filter :first_name
  filter :last_name
  filter :company
  filter :email
  filter :is_site_admin
  filter :is_company_admin
  filter :is_validated
  
end
