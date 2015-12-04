class CreateCompagnies < ActiveRecord::Migration
  def change
    create_table :compagnies do |t|
      t.string :name
      t.string :address
      t.string :zip
      t.string :city
      t.string :country

      t.timestamps null: false
    end
  end
end
