module KML #:nodoc:
  # Defines a connected set of line segments. Use LineStyle to specify the color, color mode, and width of the line. 
  # When a LineString is extruded, the line is extended to the ground, forming a polygon that looks somewhat like a wall. 
  # For extruded LineStrings, the line itself uses the current LineStyle, and the extrusion uses the current PolyStyle. 
  # See the <a href="http://earth.google.com/kml/kml_tut.html">KML Tutorial</a> for examples of LineStrings (or paths).
  class LineString < Geometry
    
    # Two or more coordinate tuples, each consisting of floating point values for longitude, latitude, and altitude. 
    # The altitude component is optional.
    def coordinates
      @coordinates
    end
    
    # Set the coordinates. When specifying as a String, insert a space or linebreak between tuples.  Do not include spaces 
    # within a tuple.
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
      xm.LineString {
        super
        xm.coordinates(coordinates.collect { |c| c.join(',') }.join(" "))
      }
    end
  end
end
