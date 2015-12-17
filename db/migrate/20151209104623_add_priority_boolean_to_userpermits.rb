class AddPriorityBooleanToUserpermits < ActiveRecord::Migration
  def change
    add_column :userpermits, :priority, :boolean, default: false
  end
end
