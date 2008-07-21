module KML #:nodoc:
  # A document contains 0 or more features and 0 or more schemas.
  class Document < Container
    attr_accessor :schemas
    
    # Shared styles
    attr_accessor :styles
    
    def schemas
      @schemas ||= []
    end
    
    def styles
      @styles ||= []
    end
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.Document {
        super
        styles.each { |style| style.render(xm) }
        features.each { |feature| feature.render(xm) }
        schemas.each { |schema| schema.render(xm) }
      }
    end    
  end
end
