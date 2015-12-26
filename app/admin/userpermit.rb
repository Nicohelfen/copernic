ActiveAdmin.register Userpermit do

  permit_params :compagny_id, :user_id, :priority

  belongs_to :user
    navigation_menu :user


  index do

    selectable_column
    column :compagny
    column :priority
    actions
  end

  form do |f|

    inputs 'Details' do
      input :compagny
      input :priority
    end

  actions

  end

 # controller do
 #      def show
 #        params[:user] = User.find(params[:id])
 #        show!
 #      end
 #    end

 #    show do
 #      attributes_table do
 #        row "User" do
 #          link_to params[:user].display_name, user_path(params[:user].slug)
 #        end
 #      end
 #    end


end

  # , input_html: { disabled: true } => For show but not update





