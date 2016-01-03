ActiveAdmin.register User do


  permit_params :email, :admin, :name, :firstname

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
      actions
  end


  form do |f|

    inputs 'Details' do
      input :id, input_html: { disabled: true }
      input :name
      input :firstname
      input :email, input_html: { disabled: true }
      input :active
      input :admin

    end

  actions

  end

end
