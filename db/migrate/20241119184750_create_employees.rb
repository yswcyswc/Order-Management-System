class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.references :user, null: false, foreign_key: true
      t.string :ssn
      t.date :date_hired
      t.date :date_terminated
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
