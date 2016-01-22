class RemoveUpdateTimeToOrganizations < ActiveRecord::Migration
  def change
    remove_column(:organizations, :update_time, index: false, foreign_key: false)
    add_column :organizations, :update_time, :string
  end
end
