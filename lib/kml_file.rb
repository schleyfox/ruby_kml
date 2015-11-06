# The KMLFile class is the top level class for constructing KML files. To create a new KML file
# create a KMLFile instance and add KML objects to its objects. For example:
#
#   f = KMLFile.new
#   f.objects << Placemark.new(
#     :name => 'Simple placemark',
#     :description => 'Attached to the ground. Intelligently places itself at the height of the underlying terrain.',
#     :geometry => Point.new(:coordinates=>'-122.0822035425683,37.42228990140251,0')
#   )
#   puts f.render
class KMLFile
  attr_accessor :objects

  # The objects in the KML file
  def objects
    @objects ||= []
  end

  # Render the KML file
  def render(xm=Builder::XmlMarkup.new(:indent => 2))
    xm.instruct!
    xmlnses = {}
    xmlnses["xmlns".to_sym] = "http://www.opengis.net/kml/2.2"
    xmlnses["xmlns:gx".to_sym] = "http://www.google.com/kml/ext/2.2"
    xmlnses["xmlns:kml".to_sym] = "http://www.opengis.net/kml/2.2"
    xmlnses["xmlns:atom".to_sym] = "http://www.w3.org/2005/Atom"
    xm.kml(**xmlnses) {
      objects.each { |o| o.render(xm) }
    }
  end

  def save filename
    File.open(filename, 'w') { |f| f.write render }
  end

end

require 'kml/object'
