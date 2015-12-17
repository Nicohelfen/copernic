class AddCounterReferenceToFlows < ActiveRecord::Migration
  def change
    add_reference :flows, :counter, index: true, foreign_key: true
  end
end
