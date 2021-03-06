ActiveAdmin.register User do
  skip_before_action :control_active_user

  permit_params :email, :admin, :name, :firstname, :active, :manager

  sidebar "User permit" do
    ul do
    if params[:id] != nil
      li link_to "Userpermits",    admin_user_userpermits_path(params[:id])
    end
    end
  end

  index do
      selectable_column
      column :id
      column :name
      column :firstname
      column :email
      column :active
      column :admin
      column :manager
      actions
  end


  form do |f|

    inputs 'Details' do
      input :id, input_html: { disabled: true }
      input :name
      input :firstname
      input :email
      input :active
      input :admin
      input :manager


    end

  actions

  end

end
