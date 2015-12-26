class AddSequenceToLevel < ActiveRecord::Migration
  def change
     add_column :levels, :sequence, :integer, default: false
     add_column :levels, :removal, :boolean, default: false
  end
end
