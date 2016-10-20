class AddIdCompagnyToOrganization < ActiveRecord::Migration
  def change
    add_reference :organizations, :compagny,  index: true, foreign_key: true
  end
end
