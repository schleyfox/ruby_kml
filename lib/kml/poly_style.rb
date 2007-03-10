module KML
  # Specifies the drawing style for all polygons, including polygon extrusions (which look like the walls of buildings) 
  # and line extrusions (which look like solid fences).
  class PolyStyle < ColorStyle
    attr_accessor :fill
    attr_accessor :outline
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.PolyStyle {
        super
        xm.fill(fill) unless fill.nil?
        xm.outline(outline) unless outline.nil?
      }
    end
  end
end