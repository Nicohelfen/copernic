class CreateUserpermits < ActiveRecord::Migration
  def change
    create_table :userpermits do |t|
      t.references :compagny, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
