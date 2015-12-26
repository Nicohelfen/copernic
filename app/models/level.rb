class Level < ActiveRecord::Base
  belongs_to :compagny
  has_many :flows, dependent: :nullify

  validates :sequence, presence: true
  validates :compagny_id, presence: true

end
