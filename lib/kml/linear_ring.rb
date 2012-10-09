# Source code for producing a LinearRing element:
#
# <LinearRing id="ID">
#   <!-- specific to LinearRing -->
#   <extrude>0</extrude>                       <!-- boolean -->
#   <tessellate>0</tessellate>                 <!-- boolean -->
#   <altitudeMode>clampToGround</altitudeMode> 
#     <!-- kml:altitudeModeEnum: clampToGround, relativeToGround, or absolute -->
#   <coordinates>...</coordinates>             <!-- lon,lat[,alt] tuples --> 
# </LinearRing>

module KML #:nodoc:
  # Defines a closed line string, typically the outer boundary of a Polygon. Optionally, a LinearRing can also 
  # be used as the inner boundary of a Polygon to create holes in the Polygon. A Polygon can contain multiple 
  # LinearRing instances used as inner boundaries.
  class LinearRing < Geometry
    # Four or more tuples, each consisting of floating point values for longitude, latitude, and altitude. 
    # The altitude component is optional. Do not include spaces within a tuple. The last coordinate must be 
    # the same as the first coordinate. Coordinates are expressed in decimal degrees only.
    def coordinates
      @coordinates
    end
    
    # Set the coordinates
    def coordinates=(c)
      case c
      when String
        @coordinates = c.strip.split(/\s+/).collect { |coord| coord.split(',') }
      when Array
        c.each do |coord_array|
          unless coord_array.is_a?(Array)
            raise ArgumentError, "If set with an array, coordinates must be specified as an array of arrays"
          end
        end
        @coordinates = c
      else
        raise ArgumentError, "Coordinates must either be a String or an Array of Arrays"
      end
    end
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      raise ArgumentError, "Coordinates required" if coordinates.nil?
      xm.LinearRing {
        super
        xm.coordinates(coordinates.collect { |c| c.join(',') }.join(" "))
      }
    end
  end
end
