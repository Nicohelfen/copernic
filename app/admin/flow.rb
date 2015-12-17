ActiveAdmin.register Flow do

permit_params :code, :name, :deliverable, :date_sale, :level

  index do
      selectable_column
      column :code
      column :name
      column :compagny
      column :deliverable
      column :date_sale
      column :level
      column :created_at

      actions
  end


end
