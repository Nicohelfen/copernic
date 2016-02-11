class AddUpdateTimeToPersons < ActiveRecord::Migration
  def change
     add_column :people , :update_time, :date
  end
end
