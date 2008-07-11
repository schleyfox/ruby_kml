module KML
  class MultiGeometry < Geometry 
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.MultiGeometry { features.each { |f| f.render(xm) } }
    end    
  end
end
