require 'open-uri'
require 'timeout'

namespace :squid do
	desc "pings and reaquires all devices"
	task ping: :environment do
		devices = Device.all
		devices.each do |device|
			puts "name: #{device.name} status: #{device.status} ip: #{device.ip}"
      begin
        Timeout::timeout(5) do
          if device.ping
            device.touch
            puts "device #{device.name} fonud"
            if device.acquire 3008
              puts "device #{device.name} acquired"
            else
              puts "device #{device.name} could not be acquired"
            end
          else
            puts "device #{device.name} has refused the connection or errored"
          end

        end
      rescue Timeout::Error
        #something timed out
        puts "device #{device.name}: He's dead, Jim"
      end
		end
	end
end
