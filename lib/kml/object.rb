module KML #:nodoc:
  # Base class for all KML objects
  class Object
    # The KML object ID
    attr_accessor :id
    
    # Initialize the object, optionally passing a Hash of attributes to set.
    def initialize(attributes=nil)
      if attributes
        case attributes
        when Hash
          attributes.each do |name, value|
            self.__send__("#{name}=".to_sym, value)
          end
        else
          raise ArgumentError, "Attributes must be specified as a Hash"
        end
      end
    end
  end
end

require 'kml/feature'
require 'kml/geometry'
require 'kml/color_style'
require 'kml/style_selector'
require 'kml/link'
require 'kml/icon'
require 'kml/lat_lon_box'
