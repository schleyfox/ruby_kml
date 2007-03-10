module KML
  # A Style defines an addressable style group that can be referenced by StyleMaps and Features. Styles affect 
  # how Geometry is presented in the 3D viewer and how Features appear in the Places panel of the List view. 
  # Shared styles are collected in a Document and must have an id defined for them so that they can be referenced 
  # by the individual Features that use them.
  class Style < StyleSelector
    attr_accessor :icon_style
    attr_accessor :label_style
    attr_accessor :line_style
    attr_accessor :poly_style
    attr_accessor :balloon_style
    attr_accessor :list_style
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.Style(:id => id) {
        %w(Icon Label Line Poly Balloon List).each do |name| 
          field = "#{name.downcase}_style".to_sym
          self.__send__(field).render(xm) unless self.__send__(field).nil?
        end
      }
    end
  end
end