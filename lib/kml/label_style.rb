# Source file contains the code for creating the LabelStyle element:
#
# <Style id="ID">
#   <!-- specific to LabelStyle -->
#   <scale>1</scale>                   <!-- float -->       
# </LabelStyle>

module KML #:nodoc:
  # Specifies how icons for point Placemarks are drawn, both in the Places panel and in the 3D viewer of 
  # Google Earth. The Icon object specifies the icon image. The +scale+ specifies the x, y scaling of the 
  # icon.
  class LabelStyle < KML::Object
   
    # Resizes the label (default=1).
    attr_accessor :scale
    
  
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.LabelStyle {
        xm.scale(scale) unless scale.nil?
      }
    end
  end
end

