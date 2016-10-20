class AddTokenToCompagnies < ActiveRecord::Migration
  def change
     add_column :compagnies , :token, :string
  end
end
