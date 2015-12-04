class Compagny < ActiveRecord::Base

has_many :levels, dependent: :destroy


  # validates :name, presence: true
  # validates :address, presence: true
  # validates :zip, presence: true
  # validates :city, presence: true
  # validates :country, presence: true
end
