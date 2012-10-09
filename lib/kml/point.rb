# <Point id="ID">
#   <!-- specific to Point -->
#   <extrude>0</extrude>                   <!-- boolean -->
#   <tessellate>0</tessellate>             <!-- boolean -->
#   <altitudeMode>clampToGround</altitudeMode> 
#     <!-- kml:altitudeModeEnum: clampToGround, relativeToGround, or absolute -->
#   <coordinates>...</coordinates>         <!-- lon,lat[,alt] -->
# </Point>
module KML
  class Point < Geometry
    
    # A single tuple consisting of floating point values for longitude, latitude, and altitude (in that order). 
    # Longitude and latitude values are in degrees, where:
    #
    # * longitude >= -180 and <= 180
    # * latitude >= -90 and <= 90
    # * altitude values (optional) are in meters above sea level
    def coordinates
      @coordinates
    end
    
    # Set the coordinates
    def coordinates=(c)
      case c
      when String
        @coordinates = c.strip.split(',')
        unless @coordinates.length == 2 || @coordinates.length == 3
          raise "Coordinates string may only have 2 parts (indicating lat and long) or 3 parts (lat, long and altitude)"
        end
      when Array
        @coordinates = c
      when Hash
        @coordinates = [:lng, :lat, :alt].collect {|attr| c[attr]}.compact
      else
        raise ArgumentError, "Coordinates must be either a String, Hash or an Array"
      end
    end
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.Point {
        super
        xm.coordinates(coordinates.join(","))
      }
    end
    
  end
end
