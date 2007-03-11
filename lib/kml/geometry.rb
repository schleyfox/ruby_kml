module KML
  class Geometry < KML::Object
    # Specifies whether to connect the point to the ground. Extrusion requires that the point's +altitude_mode+ be 
    # either "relativeToGround" or "absolute" and that within the +coordinates+, the altitude component be greater 
    # than 0 (that is, in the air). Default is false.
    def extrude?
      @extrude
    end
    
    # Set to true to extrude.
    def extrude=(v)
      @extrude = v
    end
    
    # Return nil if extrude has not been defined, otherwise return '1' for true or '0' for false.
    def extrude
      return nil unless @extrude
      @extrude ? '1' : '0'
    end
    
    # Specifies whether to allow lines and paths to follow the terrain. This specification applies only to LineStrings 
    # (paths) and LinearRings (polygons) that have an +altitude_mode+ of "clampToGround". Very long lines should enable 
    # tessellation so that they follow the curvature of the earth (otherwise, they may go underground and be hidden).
    # Default is false.
    def tessellate?
      @tessellate
    end
    
    # Set to true to tessellate.
    def tessellate=(v)
      @tessellate = v
    end
    
    # Return nil if tessellate has not been defined, otherwise return '1' for true or '0' for false.
    def tessellate
      return nil unless @tessellate
      @tessellate ? '1' : '0'
    end
    
    # Specifies how altitude components in the <coordinates> element are interpreted. Possible values are:
    # 
    # * clampToGround - (default) Indicates to ignore an altitude specification (for example, in the +coordinates+).
    # * relativeToGround - Sets the altitude of the element relative to the actual ground elevation of a particular 
    #   location. For example, if the ground elevation of a location is exactly at sea level and the altitude for a 
    #   point is set to 9 meters, then the elevation for the icon of a point placemark elevation is 9 meters with 
    #   this mode. However, if the same coordinate is set over a location where the ground elevation is 10 meters 
    #   above sea level, then the elevation of the coordinate is 19 meters. A typical use of this mode is for placing 
    #   telephone poles or a ski lift.
    # * absolute - Sets the altitude of the coordinate relative to sea level, regardless of the actual elevation 
    #   of the terrain beneath the element. For example, if you set the altitude of a coordinate to 10 meters with 
    #   an absolute altitude mode, the icon of a point placemark will appear to be at ground level if the terrain 
    #   beneath is also 10 meters above sea level. If the terrain is 3 meters above sea level, the placemark will 
    #   appear elevated above the terrain by 7 meters. A typical use of this mode is for aircraft placement.
    def altitude_mode
      @altitude_mode || 'clampToGround'
    end
    
    def altitude_mode_set?
      !(@altitude_mode.nil?)
    end
    
    # Set the altitude mode
    def altitude_mode=(mode)
      allowed_modes = %w(clampToGround relativeToGround absolute)
      if allowed_modes.include?(mode)
        @altitude_mode = mode
      else
        raise ArgumentError, "Must be one of the allowed altitude modes: #{allowed_modes.join(',')}"
      end
    end
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.extrude(extrude) unless extrude.nil?
      xm.tessellate(tessellate) unless tessellate.nil?
      xm.altitudeMode(altitude_mode) if altitude_mode_set?
    end
    
  end
end

require 'kml/point'
require 'kml/line_string'
require 'kml/linear_ring'
require 'kml/polygon'
require 'kml/model'
require 'kml/multi_geometry'