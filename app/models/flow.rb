class Flow < ActiveRecord::Base
  belongs_to :counter
  belongs_to :compagny
  belongs_to :level

  validates :level_id, presence: true

  include AlgoliaSearch
  algoliasearch do
    attribute :name, :code, :description, :level_id

  attributesToIndex ['name', 'level_id', 'code', 'unordered(description)']
  attributesForFaceting [:level_id]

  end


end
