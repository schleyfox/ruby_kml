# This file implements the ScreenOverlay type
# <ScreenOverlay id="ID">
#   <!-- inherited from Feature element -->
#   <!-- inherited from Overlay element -->
# 
#   <!-- specific to ScreenOverlay -->
#   <overlayXY x="double" y="double" xunits="fraction" yunits="fraction"/>    
#     <!-- vec2 -->
#     <!-- xunits and yunits can be one of: fraction, pixels, or insetPixels -->
#   <screenXY x="double" y="double" xunits="fraction" yunits="fraction"/>      
#     <!-- vec2 -->
#   <rotationXY x="double" y="double" xunits="fraction" yunits"fraction"/>  
#     <!-- vec2 -->
#   <size x="double" y="double" xunits="fraction" yunits="fraction"/>              
#     <!-- vec2 --> 
#   <rotation>0</rotation>                   <!-- float -->
#  </ScreenOverlay>

module KML

  class ScreenOverlay < Overlay
    
    # A hash of options in the form of {:x, :y, :xunits, :yunits} that
    # specify the point on the overlay image that is mapped to the screen
    def overlay_xy
      @overlay_xy
    end

    # Set the overlay_xy coordinates
    #
    # xunits and yunits are :pixels or :fraction
    def overlay_xy= coords
      @overlay_xy = {:xunits => :fraction, :yunits => :fraction}.merge(coords)
    end

    # A hash of options in the form of {:x, :y, :xunits, :yunits} that
    # specify the position on the screen where the image is mapped
    def screen_xy
      @screen_xy
    end

    #Set the screen_xy coordinates
    #
    # xunits and yunits are :pixels or :fraction
    def screen_xy= coords
      @screen_xy = {:xunits => :fraction, :yunits => :fraction}.merge(coords)
    end

    attr_accessor :size, :rotation

    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.ScreenOverlay {
        super
        xm.overlayXY(@overlay_xy) if @overlay_xy
        xm.screenXY(@screen_xy) if @screen_xy
        xm.size{ @size } if @size
        xm.rotation{ @rotation } if @rotation
      }
    end
  end
end
