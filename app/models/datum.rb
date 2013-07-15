class Datum < ActiveRecord::Base
  attr_accessible :data, :uuid
  validates :uuid, presence: true
  belongs_to :device, foreign_key: 'uuid', primary_key: 'uuid'

  def created_at
    created_at= attributes["created_at"]
    created_at ? created_at.to_f : nil
  end

  def updated_at
    updated_at= attributes["created_at"]
    updated_at ? updated_at.to_f : nil
  end
end
