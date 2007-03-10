module KML #:nodoc:
  # A short description of a feature. In Google Earth, this description is displayed in the Places panel 
  # under the name of the feature. If a Snippet is not supplied, the first two lines of the description are 
  # used. In Google Earth, if a Placemark contains both a description and a Snippet, the Snippet appears 
  # beneath the Placemark in the Places panel, and the description appears in the Placemark's description 
  # balloon. This object does not support HTML markup.
  class Snippet
    # The maximum number of lines to display.
    attr_accessor :max_lines
    
    # The text that is displayed (HTML not supported)
    attr_accessor :text
    
    # Initialize the snippet with the given text and optionally with the given max_lines value.
    def initialize(text, max_lines=nil)
      @text = text
      @max_lines = max_lines
    end
    
    # The maximum number of lines to display. Default is 2
    def max_lines
      @max_lines ||= 2
    end
  end
end