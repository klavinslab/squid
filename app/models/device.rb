class Device < ActiveRecord::Base
  attr_accessible :ip, :name, :port, :state, :status, :uuid
  validates :uuid, presence: true
  validates :ip, presence: true
  validates :port, presence: true
  
  has_many :data, foreign_key: 'uuid', primary_key: 'uuid'

end
