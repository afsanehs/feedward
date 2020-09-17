class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.text :description
      t.boolean :is_accepted
      t.belongs_to :employee, index: true #cette ligne rajoute la référence à la table user
      t.belongs_to :employer, index: true #cette ligne rajoute la référence à la table user

      t.timestamps
    end
  end
end
