class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.date :date
      t.float :grand_total
      t.string :payment_receipt

      # t.timestamps
    end
  end
end
