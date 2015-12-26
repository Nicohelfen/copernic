ActiveAdmin.register Counter do

permit_params :name, :start, :actual, :number_char, :compagny_id

  index do
      selectable_column
      column :id
      column :name
      column :compagny
      column :start
      column :actual
      column :number_char
      actions
  end

  form do |f|

    inputs 'Details' do
      input :compagny, input_html: { disabled: true }
      input :name, input_html: { disabled: true }
      input :start, input_html: { disabled: true }
      input :actual
      input :number_char, input_html: { disabled: true }
    end
  end

end
