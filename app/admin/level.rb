ActiveAdmin.register Level do

  belongs_to :compagny
  navigation_menu :compagny

  permit_params :compagny_id, :name, :sequence


end



