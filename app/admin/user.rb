ActiveAdmin.register User do


  permit_params :email, :admin

  # sidebar "Compagny permit", only: [:show, :edit] do
  #   ul do

  #   li link_to "Userpermits",    admin_user_Userpermit_path(user)
  #   end
  # end

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
