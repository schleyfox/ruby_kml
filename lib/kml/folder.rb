module KML #:nodoc:
  # A Folder is used to arrange other Features hierarchically (Folders, Placemarks, NetworkLinks, 
  # or Overlays). A Feature is visible only if it and all its ancestors are visible.
  class Folder < Container
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.Folder {
        super
        features.each { |f| f.render(xm) }
      }
    end
  end
end