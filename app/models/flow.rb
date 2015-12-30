class Flow < ActiveRecord::Base
  belongs_to :counter
  belongs_to :compagny
  belongs_to :level

  validates :level_id, presence: true
end
