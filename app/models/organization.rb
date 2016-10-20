class Organization < ActiveRecord::Base
  # validates :pipe_organization_id, presence: true
  has_many :persons, dependent: :nullify
  belongs_to :compagny
end
