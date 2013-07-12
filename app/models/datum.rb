class Datum < ActiveRecord::Base
  attr_accessible :data, :uuid
  validates :uuid, presence: true
  belongs_to :device, foreign_key: 'uuid', primary_key: 'uuid'
end
