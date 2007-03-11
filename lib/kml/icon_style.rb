# Source file contains the code for creating the IconStyle element:
#
# <IconStyle id="ID">
#   <!-- inherited from ColorStyle -->
#   <color>ffffffff</color>            <!-- kml:color -->
#   <colorMode>normal</colorMode>      <!-- kml:colorModeEnum:normal or random -->
# 
#   <!-- specific to IconStyle -->
#   <scale>1</scale>                   <!-- float -->
#   <heading>0</heading>               <!-- float -->
#   <Icon>
#     <href>...</href>
#   </Icon> 
#   <hotSpot x="0.5"  y="0.5" 
#     xunits="fraction" yunits="fraction"/>    <!-- kml:vec2Type -->                    
# </IconStyle>

module KML #:nodoc:
  # Specifies how icons for point Placemarks are drawn, both in the Places panel and in the 3D viewer of 
  # Google Earth. The Icon object specifies the icon image. The +scale+ specifies the x, y scaling of the 
  # icon.
  class IconStyle < ColorStyle
    # Compass direction, in degrees. Default=0 (North). (
    # <a href="http://earth.google.com/kml/kml_tags_21.html#heading">See diagram.) Values range from 0 to 
    # ±180 degrees.
    attr_accessor :heading
    
    # Resizes the icon (default=1).
    attr_accessor :scale
    
    # A custom Icon.
    attr_accessor :icon
    
    # Specifies the position within the Icon that is "anchored" to the Point specified in the Placemark.
    # See KML::HotSpot
    attr_accessor :hot_spot
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.IconStyle {
        super
        xm.scale(scale) unless scale.nil?
        xm.heading(heading) unless heading.nil?
        icon.render(xm) unless icon.nil?
        unless hot_spot.nil?
          xm.hotSpot(:x => hot_spot.x, :y => hot_spot.y, :xunits => hot_spot.xunits, :yunits => hot_spot.yunits)
        end
      }
    end
  end
end

require 'kml/hot_spot'