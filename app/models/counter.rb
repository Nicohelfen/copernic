class Counter < ActiveRecord::Base

  validates :name, presence: true
  validates :start, presence: true
  validates :actual, presence: true
  validates :number_char, presence: true

end
