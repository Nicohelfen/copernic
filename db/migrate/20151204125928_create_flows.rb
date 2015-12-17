class CreateFlows < ActiveRecord::Migration
  def change
    create_table :flows do |t|
      t.references :counter, index: true, foreign_key: true
      t.references :compagny, index: true, foreign_key: true
      t.integer :code
      t.string :name
      t.text :description
      t.integer :deliverable
      t.date :date_sale
      t.references :level, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
