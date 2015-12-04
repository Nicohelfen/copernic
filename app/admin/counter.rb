ActiveAdmin.register Counter do

permit_params :name, :start, :actual, :number_char

  index do
      selectable_column
      column :id
      column :name
      column :start
      column :actual
      column :number_char
      actions
  end

end
