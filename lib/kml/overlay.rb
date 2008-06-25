module KML
  # Overlay is the base type for image overlays drawn on the planet surface or on the screen. +icon+ specifies the 
  # image to use and can be configured to reload images based on a timer or by camera changes. This element also 
  # includes specifications for stacking order of multiple overlays and for adding color and transparency values to 
  # the base image.
  class Overlay < Feature
    attr_accessor :color
    attr_accessor :draw_order
    attr_accessor :icon
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      super
      xm.color(color) unless color.nil?
      xm.drawOrder(drawOrder) unless draw_order.nil?
      icon.render(xm) unless icon.nil?
    end
  end
end

require 'kml/ground_overlay'
require 'kml/screen_overlay'
