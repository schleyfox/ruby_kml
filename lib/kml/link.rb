module KML #:nodoc:
  # Link specifies the location of any of the following:
  #
  # * KML files fetched by network links
  # * Image files used by icons in icon styles, ground overlays, and screen overlays
  # * Model files used in the Model element
  # 
  # The file is conditionally loaded and refreshed, depending on the refresh parameters supplied here. 
  # Two different sets of refresh parameters can be specified: one set is based on time (+refresh_mode+ and 
  # +refresh_interval+) and one is based on the current "camera" view (+view_refresh_mode+ and 
  # +view_refresh_time+). In addition, Link specifies whether to scale the bounding box parameters that 
  # are sent to the server (+view_bound_scale+ and provides a set of optional viewing parameters that can 
  # be sent to the server (+view_format+) as well as a set of optional parameters containing version and 
  # language information.
  # 
  # When a file is fetched, the URL that is sent to the server is composed of three pieces of information:
  # 
  # * the +href+ (Hypertext Reference) that specifies the file to load.
  # * an arbitrary format string that is created from (a) parameters that you specify in +view_format+ or 
  #   (b) bounding box parameters (this is the default and is used if no +view_format+ is specified).
  # * a second format string that is specified in +http_query+.
  # 
  # If the file specified in +href+ is a local file, +view_format+ and +http_query+ are not used.
  class Link < KML::Object
    attr_accessor :href
    attr_accessor :refresh_mode
    attr_accessor :refresh_interval
    attr_accessor :view_refresh_mode
    attr_accessor :view_refresh_time
    attr_accessor :view_bound_scale
    attr_accessor :view_format
    attr_accessor :http_query
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      raise InvalidKMLError, "Link.href must be specified" if href.nil?
      xm.Link {
        self.elements.each do |a|
          xm.__send__(a, self.__send__(a)) unless self.__send__(a).nil?
        end
      }
    end
    
    protected
    def elements
      [
        :href, :refresh_mode, :refresh_interval, :view_refresh_mode, :view_refresh_time, 
        :view_bound_scale, :view_format, :http_query
      ]
    end
  end
end