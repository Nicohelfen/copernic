class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.references :compagny, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
