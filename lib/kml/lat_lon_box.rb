module KML #:nodoc:
  # Specifies where the top, bottom, right, and left sides of a bounding box for the ground overlay are aligned. Values for 
  # +north+, +south+, +east+, and +west+ are required.
  #
  # * +north+ (required) Specifies the latitude of the north edge of the bounding box, in decimal degrees from 0 to ±90.
  # * +south+ (required) Specifies the latitude of the south edge of the bounding box, in decimal degrees from 0 to ±90.
  # * +east+ (required) Specifies the longitude of the east edge of the bounding box, in decimal degrees from 0 to ±180. 
  #   (For overlays that overlap the meridian of 180° longitude, values can extend beyond that range.)
  # * +west+ (required) Specifies the longitude of the west edge of the bounding box, in decimal degrees from 0 to ±180. 
  #   (For overlays that overlap the meridian of 180° longitude, values can extend beyond that range.)
  # * +rotation+ (optional) specifies a rotation of the overlay about its center, in degrees. Values can be ±180. The 
  #   default is 0 (north). Rotations are specified in a clockwise direction.
  
  class LatLonBox < KML::Object
    attr_accessor :north
    attr_accessor :south
    attr_accessor :east
    attr_accessor :west
    attr_accessor :rotation
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      raise InvalidKMLError, "LatLonBox.north is required" if north.nil?
      raise InvalidKMLError, "LatLonBox.south is required" if south.nil?
      raise InvalidKMLError, "LatLonBox.east is required" if east.nil?
      raise InvalidKMLError, "LatLonBox.west is required" if west.nil?
      
      xm.LatLonBox {
        xm.north(north)
        xm.south(south)
        xm.east(east)
        xm.west(west)
        xm.rotation(rotation) unless rotation.nil?
      }
    end
  end
end