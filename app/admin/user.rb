ActiveAdmin.register User do

  permit_params :email, :admin

  index do
      selectable_column
      column :id
      column :email
      column :name
      column :created_at
      column :admin
      actions
  end

end
