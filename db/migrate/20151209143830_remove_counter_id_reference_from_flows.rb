class RemoveCounterIdReferenceFromFlows < ActiveRecord::Migration
  def change
    remove_reference(:flows, :counter, index: true, foreign_key: true)
  end
end
