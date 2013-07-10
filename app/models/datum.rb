class Datum < ActiveRecord::Base
  attr_accessible :data, :uuid
  validates :uuid, presence: true
end
