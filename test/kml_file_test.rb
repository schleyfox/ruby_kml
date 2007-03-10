require "#{File.dirname(__FILE__)}/test_helper"
class KMLFileTest < Test::Unit::TestCase
  include KML
  
  def test_placemark
    kml = KMLFile.new
    kml.objects << Placemark.new(
      :name => 'Simple placemark', 
      :description => 'Attached to the ground. Intelligently places itself at the height of the underlying terrain.',
      :geometry => Point.new(:coordinates=>'-122.0822035425683,37.42228990140251,0')
    )
    write_and_show(kml, File.dirname(__FILE__) + '/simple_placemark.kml')
  end
  
  def test_cdata_description
    description = <<-DESC
<h1>CDATA Tags are useful!</h1>
<p><font color="red">Text is <i>more readable</i> and 
<b>easier to write</b> when you can avoid using entity 
references.</font></p>
DESC
    
    kml = KMLFile.new
    document = Document.new(
      :name => 'Document with CDATA example', 
      :snippet => Snippet.new("Document level snippet")
    )
    document.features << Placemark.new(
      :name => 'CDATA example', 
      :description => description,
      :snippet => Snippet.new("Example of a snippet"),
      :geometry => Point.new(:coordinates=>'-122.0822035425683,37.4228,0')
    )
    kml.objects << document
    write_and_show(kml, File.dirname(__FILE__) + '/cdata_and_snippet.kml')
  end
  
  def test_ground_overlays
    kml = KMLFile.new
    folder = Folder.new(
      :name => 'Ground Overlays',
      :description => 'Examples of ground overlays'
    )
    folder.features << GroundOverlay.new(
      :name => 'Large-scale overlay on terrain',
      :description => 'Overlay shows Mount Etna erupting on July 13th, 2001.',
      :icon => Icon.new(:href => 'http://code.google.com/apis/kml/documentation/etna.jpg'),
      :lat_lon_box => LatLonBox.new(
        :north => 37.91904192681665,
        :south => 37.46543388598137,
        :east => 15.35832653742206,
        :west => 14.60128369746704,
        :rotation => -0.1556640799496235
      )
    )
    kml.objects << folder
    write_and_show(kml, File.dirname(__FILE__) + '/ground_overlays.kml')
  end
  
  def test_paths
    kml = KMLFile.new
    kml.objects << Document.new(
      :name => 'Paths',
      :description => 'Examples of paths. Note that the tessellate tag is by default
            set to 0. If you want to create tessellated lines, they must be authored
            (or edited) directly in KML.',
      :styles => [
        Style.new(
          :id => 'yellowLineGreenPoly',
          :line_style => LineStyle.new(:color => '7f00ffff', :width => 4),
          :poly_style => PolyStyle.new(:color => '7f00ff00')
        )
      ],
      :features => [
        Placemark.new(
          :name => 'Absolute Extruded',
          :description => 'Transparent green wall with yellow outlines',
          :style_url => '#yellowLineGreenPoly',
          :geometry => LineString.new(
            :extrude => true,
            :tessellate => true,
            :altitude_mode => 'absolute',
            :coordinates => '-112.2550785337791,36.07954952145647,2357
                      -112.2549277039738,36.08117083492122,2357
                      -112.2552505069063,36.08260761307279,2357
                      -112.2564540158376,36.08395660588506,2357
                      -112.2580238976449,36.08511401044813,2357
                      -112.2595218489022,36.08584355239394,2357
                      -112.2608216347552,36.08612634548589,2357
                      -112.262073428656,36.08626019085147,2357
                      -112.2633204928495,36.08621519860091,2357
                      -112.2644963846444,36.08627897945274,2357
                      -112.2656969554589,36.08649599090644,2357'
          )
        )
      ]
    )
    #puts kml.render
    write_and_show(kml, File.dirname(__FILE__) + '/paths.kml')
  end
end