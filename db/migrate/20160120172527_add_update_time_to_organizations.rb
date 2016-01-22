class AddUpdateTimeToOrganizations < ActiveRecord::Migration
  def change
     add_column :organizations, :update_time, :date
  end
end
