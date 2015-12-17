class Userpermit < ActiveRecord::Base
  belongs_to :compagny
  belongs_to :user

  validates :compagny, presence: true
  validates :user, presence: true
end
