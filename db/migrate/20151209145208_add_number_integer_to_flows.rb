class AddNumberIntegerToFlows < ActiveRecord::Migration
  def change
    add_column :flows, :number, :integer, default: false
  end
end
