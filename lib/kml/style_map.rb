# Source file that defines a StyleMap element
#
# <StyleMap id="ID">
#   <!-- extends StyleSelector -->
#   <!-- elements specific to StyleMap -->
#   <Pair id="ID">
#     <key>normal</key>              <!-- kml:styleStateEnum:  normal or highlight
#     <styleUrl>...</styleUrl>       <!-- anyURI -->
#   </Pair>
# </StyeMap>

module KML #:nodoc:
  # A StyleMap maps between two different icon styles. Typically a StyleMap element is used to provide 
  # separate normal and highlighted styles for a placemark, so that the highlighted version appears when 
  # the user mouses over the icon in Google Earth.
  class StyleMap < StyleSelector
    # Key/styleUrl pairs
    attr_accessor :pairs
    
    # Get the pairs Hash. Each key/value pair  maps a mode (normal or highlight) to the predefined style URL. 
    # Each pair contains a key and a value which references the style. For referenced style elements that 
    # are local to the KML document, a simple # referencing is used. For styles that are contained in 
    # external files, use a full URL along with # referencing.
    def pairs
      @pairs ||= {}
    end
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.StyleMap(:id => id) {
        pairs.each do |key, value|
          xm.Pair {
            xm.key(key)
            xm.styleUrl(value)
          }
        end
      }
    end
  end
end