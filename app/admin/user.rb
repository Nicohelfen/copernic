ActiveAdmin.register User do


  permit_params :email, :admin

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
      column :email
      column :admin
      actions
  end


  form do |f|

    inputs 'Details' do
      input :id, input_html: { disabled: true }
      input :email, input_html: { disabled: true }
      input :admin

    end

  actions

  end

end
