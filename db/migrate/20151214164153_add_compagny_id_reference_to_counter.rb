class AddCompagnyIdReferenceToCounter < ActiveRecord::Migration
  def change
    add_reference :counters, :compagny, index: true, foreign_key: true
  end
end
