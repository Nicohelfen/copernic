class Counter < ActiveRecord::Base

  has_many :flows, dependent: :nullify
  belongs_to :compagny

  validates :name, presence: true
  validates :start, presence: true
  validates :actual, presence: true
  validates :number_char, presence: true
  validates :compagny, presence: true


end


