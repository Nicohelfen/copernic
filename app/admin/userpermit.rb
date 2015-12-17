ActiveAdmin.register Userpermit do

  permit_params :compagny_id, :user_id, :priority


  index do

    selectable_column
    column :compagny
    column :user
    column :priority
    actions
  end




end
