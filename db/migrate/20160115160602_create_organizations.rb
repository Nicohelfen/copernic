class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.integer :pipe_organization_id
      t.string :name

      t.timestamps null: false
    end
  end
end
