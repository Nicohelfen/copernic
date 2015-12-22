class RemovePreferenceTable < ActiveRecord::Migration
  def change
    remove_reference(:preferences, :user, index: true, foreign_key: true)
    remove_reference(:preferences, :compagny, index: true, foreign_key: true)
    drop_table(:preferences)
  end
end
