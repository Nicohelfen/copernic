class AddActiveFlagToOrganizations < ActiveRecord::Migration
  def change
     add_column :organizations, :active_flag, :boolean, default: false
  end
end
