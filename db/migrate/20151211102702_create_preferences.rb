class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :user, index: true, foreign_key: true
      t.references :compagny, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
