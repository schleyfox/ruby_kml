module KML #:nodoc:
  # Base class for specifying the color and color mode of extended style types.
  class ColorStyle < KML::Object
    # Color and opacity (alpha) values are expressed in hexadecimal notation. The range of values for any one color 
    # is 0 to 255 (00 to ff). For alpha, 00 is fully transparent and ff is fully opaque. The order of expression is 
    # aabbggrr, where aa=alpha (00 to ff); bb=blue (00 to ff); gg=green (00 to ff); rr=red (00 to ff). For example, 
    # if you want to apply a blue color with 50 percent opacity to an overlay, you would specify the following: 
    # 
    #   style.color = '7fff0000'
    # 
    # where alpha=0x7f, blue=0xff, green=0x00, and red=0x00.
    attr_accessor :color
    
    # Values for +color_mode+ are normal (no effect) and random. A value of random applies a random linear scale to 
    # the base +color+ as follows. 
    # 
    # * To achieve a truly random selection of colors, specify a base +color+ of white (ffffffff).
    # * If you specify a single color component (for example, a value of ff0000ff for red), random color values for 
    #   that one component (red) will be selected. In this case, the values would range from 00 (black) to ff (full red).
    # * If you specify values for two or for all three color components, a random linear scale is applied to each color 
    #   component, with results ranging from black to the maximum values specified for each component.
    # * The opacity of a color comes from the alpha component of <color> and is never randomized.
    attr_accessor :color_mode
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.color(color) unless color.nil?
      xm.colorMode(color_mode) unless color_mode.nil?
    end
  end
end

require 'kml/line_style'
require 'kml/poly_style'