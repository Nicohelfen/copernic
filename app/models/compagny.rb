class Compagny < ActiveRecord::Base

has_many :levels, dependent: :destroy
has_many :flows, dependent: :nullify
has_many :counters, dependent: :nullify
has_many :userpermits, dependent: :destroy


  # validates :name, presence: true
  # validates :address, presence: true
  # validates :zip, presence: true
  # validates :city, presence: true
  # validates :country, presence: true
end
