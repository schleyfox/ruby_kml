module KML #:nodoc:
  # This element draws an image overlay draped onto the terrain.
  class GroundOverlay < Overlay
    attr_accessor :altitude
    attr_accessor :altitude_mode
    attr_accessor :lat_lon_box
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      raise InvalidKMLError, "GroundOverlay.lat_lon_box is required" if lat_lon_box.nil?
      xm.GroundOverlay {
        super
        xm.altitude(altitude) unless altitude.nil?
        xm.altitudeMode(altitude_mode) unless altitude_mode.nil?
        lat_lon_box.render(xm)
      }
    end
  end
end