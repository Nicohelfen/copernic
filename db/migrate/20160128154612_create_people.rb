class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :pipe_person_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :phone, array: true, default: []
      t.string :job
      t.boolean :active_flag, default: true
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
