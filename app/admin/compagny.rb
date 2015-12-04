ActiveAdmin.register Compagny do

  permit_params :name, :address, :zip, :city, :country

  sidebar "Compagny Details", only: [:show, :edit] do
    ul do

      li link_to "Levels",     admin_compagny_levels_path(compagny)
    end
  end

  index do
      selectable_column
      column :id
      column :name
      column :address
      column :zip
      column :country
      actions
  end
end
