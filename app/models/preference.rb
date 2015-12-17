class Preference < ActiveRecord::Base
  belongs_to :user
  belongs_to :compagny

  validates_uniqueness_of :user_id



end
