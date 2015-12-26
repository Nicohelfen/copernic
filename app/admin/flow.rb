ActiveAdmin.register Flow do

permit_params :code, :name, :deliverable, :date_sale, :level_id

actions :all, except: [:destroy]

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

  form do |f|

    @levels = Level.where(:compagny_id=> Flow.find(params[:id]).compagny_id).sort {|s| s.sequence}

    inputs 'Details' do
      input :code, input_html: { disabled: true }
      input :name, input_html: { disabled: true }
      input :compagny, input_html: { disabled: true }
      input :level, collection: @levels
    end
  actions
  end

end
