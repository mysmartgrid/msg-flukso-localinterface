require 'net/http'
require 'json'


module FluksoLocal
  class Query
    def initialize(location)
      @location=location;
    end
    def getRawReadings(sensor_id)
      page="/sensor/#{sensor_id}"
      values=nil
      begin
      Net::HTTP.start(@location.host) do |http|
        puts "retrieving #{page}" if $verbose
        response=http.get(page);
        puts "Raw Response:" if $verbose
        puts response.body if $verbose
        values=response.body
      end
      rescue StandardError => bang
        puts "Cannot query flukso: #{bang}"
      end
      return values 
    end
    def getReadings(sensor_id)
      # todo: make appropriate nil values
      retval=Hash.new
      values=getRawReadings(sensor_id);
      if values != nil
        tmp=JSON.parse(values);
        tmp.each{|value|
          timestamp=value[0]
          value=value[1]
          #puts "Found #{timestamp} => #{value}"
          retval[timestamp]=value;
        }
      end
      jj retval if $verbose;
      return retval;
    end
  end
end
