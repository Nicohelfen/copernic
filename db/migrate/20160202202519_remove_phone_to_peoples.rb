class RemovePhoneToPeoples < ActiveRecord::Migration
  def change
    remove_column(:people, :phone, array: true, default: [])
    add_column :people, :phone, :string
  end
end
