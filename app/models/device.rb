class Device < ActiveRecord::Base
  attr_accessible :ip, :name, :port, :state, :status, :uuid
  validates :uuid, presence: true
  validates :ip, presence: true
  validates :port, presence: true
  
  has_many :data, foreign_key: 'uuid', primary_key: 'uuid'

  def acquire(squidport)
    begin
      open("http://#{self.ip}:#{self.port}/?cmd=acquire&port=#{squidport}")
    rescue OpenURI::HTTPError =>the_error
      return false
    rescue Errno::ECONNREFUSED
      return false
    end
    return true
  end

  def ping
    begin
      open("http://#{self.ip}:#{self.port}/?cmd=info", :read_timeout => 1)
    rescue OpenURI::HTTPError =>the_error
      return false
    rescue Errno::ECONNREFUSED
      return false
    end
    return true
  end

end
