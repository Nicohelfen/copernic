class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, default: false
    add_column :users, :firstname, :string, default: false
    add_column :users, :active, :boolean, default: true

  end
end
