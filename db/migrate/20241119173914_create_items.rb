class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :category
      t.integer :units_per_item
      t.float :weight
      t.boolean :active, default: true

      # t.timestamps
    end
  end
end
