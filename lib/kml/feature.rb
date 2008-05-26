# This source file implements the Feature class of KML.
#
# Basic XML chunk structure:
#
#   <name>...</name>                      <!-- string -->
#   <visibility>1</visibility>            <!-- boolean -->
#   <open>1</open>                        <!-- boolean -->
#   <address>...</address>                <!-- string -->
#   <AddressDetails xmlns="urn:oasis:names:tc:ciq:xsdschema:xAL:2.0">...
#       </AddressDetails>                 <!-- string -->
#   <phoneNumber>...</phoneNumber>        <!-- string -->
#   <Snippet maxLines="2">...</Snippet>   <!-- string -->
#   <description>...</description>        <!-- string -->
#   <LookAt>...</LookAt>
#   <TimePrimitive>...</TimePrimitive>
#   <styleUrl>...</styleUrl>              <!-- anyURI -->
#   <StyleSelector>...</StyleSelector>
#   <Region>...</Region>
#   <Metadata>...</Metadata>              <!-- user-defined data -->

module KML #:nodoc:
  # A feature is an abstract base class.
  class Feature < KML::Object
    # Accessor for the feature name
    attr_accessor :name
    
    # Return true if the feature is visible
    def visibility?
      @visibility || true
    end
    
    # If the visibility has been set then return '0' for false and '1' for true. If the visibility
    # has never been explicitly set then return nil (which means that the associated KML tag will
    # not be rendered)
    def visibility
      return nil if @visibility.nil?
      @visibility ? '1' : '0'
    end
    
    # Set to true to indicate that the feature is visible.
    def visibility=(v)
      @visibility = v
    end
    
    # Return true if the feature is expanded when initially displayed.
    def open?
      @open || true
    end
    
    # If the open has been set then return '0' for false and '1' for true. If the open has never been 
    # explicitly set then return nil (which means that the associated KML tag will not be rendered)
    def open
      return nil if @open.nil?
      @open ? '1' : '0'
    end
    
    # Set to true to indicate that the feature is expanded when displayed. Set to false to indicate that the
    # feature is collapsed.
    def open=(v)
      @open = v
    end
    
    # A string value representing an unstructured address written as a standard street, city, state address, and/or as 
    # a postal code. You can use the +address+ attribute to specify the location of a point instead of using latitude and 
    # longitude coordinates. (However, if a Point is provided, it takes precedence over the +address+.) To find out 
    # which locales are supported for this tag in Google Earth, go to the 
    # <a href="http://maps.google.com/support/bin/answer.py?answer=16634">Google Maps Help</a>.
    attr_accessor :address
    
    # A structured address, formatted as xAL, or eXtensible Address Language, an international standard for address 
    # formatting. AddressDetails is used by KML for geocoding in Google Maps only. For details, see the Google Maps 
    # API documentation. Currently, Google Earth does not use this attribute; use +address+ instead.
    attr_accessor :address_details
    
    # A string value representing a telephone number. This element is used by Google Maps Mobile only. The industry 
    # standard for Java-enabled cellular phones is RFC2806. For more information, see 
    # <a href="http://www.ietf.org/rfc/rfc2806.txt">http://www.ietf.org/rfc/rfc2806.txt</a>.
    attr_accessor :phone_number
    
    # Accessor for the snippet. See +KML::Snippet+
    attr_accessor :snippet
    # Set the snippet. See +KML::Snippet+
    def snippet=(v)
      case v
      when String
        @snippet = Snippet.new(v)
      when Snippet
        @snippet = v
      else
        raise ArgumentError, "Snippet must be a String or a Snippet"
      end
    end
    
    # User-supplied text that appears in the description balloon when the user clicks on either the feature name 
    # in the Places panel or the Placemark icon in the 3D viewer. This text also appears beneath the feature name 
    # in the Places panel if no Snippet is specified for the feature.
    # 
    # Description supports plain text as well as a subset of HTML formatting elements, including tables. It does 
    # not support other web-based technology, such as dynamic page markup (PHP, JSP, ASP), scripting languages 
    # (VBScript, Javascript), nor application languages (Java, Python).
    # 
    # If your description contains no HTML markup, Google Earth attempts to format it, replacing newlines with 
    # &lt;br&gt; and wrapping URLs with anchor tags. A valid URL string for the World Wide Web is automatically 
    # converted to a hyperlink to that URL (e.g., http://www.google.com). Consequently, you do not need to surround 
    # a URL with the &lt;a href="http://.."&gt;&lt;/a&gt; tags in order to achieve a simple link.
    attr_accessor :description
    
    # Defines a camera viewpoint associated with any element derived from Feature. See LookAt.
    attr_accessor :look_at
    
    attr_accessor :time_primitive
    
    # URI (a URI equals [URL]#ID) of a Style or StyleMap defined in a Document. If the style is in the same file, 
    # use a # reference. If the style is defined in an external file, use a full URL along with # referencing. Examples:
    #
    #   +style_url='#myIconStyleID'
    #   +style_url='http://someserver.com/somestylefile.xml#restaurant'
    attr_accessor :style_url
    
    # One or more Styles and StyleMaps can be defined to customize the appearance of any element derived from Feature 
    # or of the Geometry in a Placemark. (See BalloonStyle, ListStyle, StyleSelector, and the styles derived from 
    # ColorStyle.) A style defined within a Feature is called an "inline style" and applies only to the Feature that 
    # contains it. A style defined as the child of a Document is called a "shared style." A shared style must have an id 
    # defined for it. This id is referenced by one or more Features within the <Document>. In cases where a style element 
    # is defined both in a shared style and in an inline style for a Feature—that is, a Folder, GroundOverlay, 
    # NetworkLink, Placemark, or ScreenOverlay—the value for the Feature's inline style takes precedence over the value 
    # for the shared style.
    attr_accessor :style_selector
    attr_accessor :region
    attr_accessor :metadata
    
    # Render the object and all of its sub-elements.
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      [:name, :visibility, :address].each do |a|
        xm.__send__(a, self.__send__(a)) unless self.__send__(a).nil?
      end
      
      xm.description { xm.cdata!(description) } unless description.nil?
      xm.open(self.open) unless open.nil?
      
      xm.phoneNumber(phone_number) unless phone_number.nil?
      xm.styleUrl(style_url) unless style_url.nil?
      
      unless address_details.nil?
        xm.AddressDetails(:xmlns => "urn:oasis:names:tc:ciq:xsdschema:xAL:2.0") { address_details.render(xm) } 
      end
      
      xm.Snippet(snippet.text, snippet.max_lines) unless snippet.nil?
      
      xm.LookAt { look_at.render(xm) } unless look_at.nil?
      xm.TimePrimitive { time_primitive.render(xm) } unless look_at.nil?
      xm.StyleSelector { style_selector.render(xm) } unless style_selector.nil?
    end
  end
end

require 'kml/placemark'
require 'kml/container'
require 'kml/overlay'

require 'kml/snippet'
