module KML #:nodoc:
  # Defines an image associated with an Icon style or overlay. Icon has the same child elements as +Link+. 
  # The required href defines the location of the image to be used as the overlay or as the icon for the 
  # placemark. This location can either be on a local file system or a remote web server.
  class Icon < Link
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      raise InvalidKMLError, "Icon.href must be specified" if href.nil?
      xm.Icon {
        self.elements.each do |a|
          xm.__send__(a, self.__send__(a)) unless self.__send__(a).nil?
        end
      }
    end
  end
end