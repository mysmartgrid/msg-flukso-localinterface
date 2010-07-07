
module FluksoLocal

  class Discover
    def initialize
      @collection=FluksoCollection.new();
    end
    def getFluksoLocation
      return Location.new("IP", "PORT");
    end
  end

  class Location
    attr_reader :host, :port
    def initialize(host, port)
      @host=host
      @port=port
    end
    def to_s
      return "Flukso at #{@host}:#{@port}"
    end
  end

  class FluksoCollection
    def initialize()
      @locations=Array.new();
    end
    def locations
      return @locations
    end
    def addLocation(location)
      @location << location
    end
  end

end
