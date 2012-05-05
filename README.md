ruby_kml
========

Overview
--------

Library for generating KML(Keyhole Markup Language) files in Ruby.
Sweet if you want to place markers, overlays, and other awesome things over a google map or google earth.


Install
-------

    gem install ruby_kml


Examples
--------

See `test/kml_file_test.rb` for more examples

    kml = KMLFile.new
    folder = KML::Folder.new(:name => 'Melbourne Stations')
    [
      ["Flinders St",    -37.818078, 144.966811],
      ["Southern Cross", -37.818358, 144.952417],
    ].each do |name, lat, lng|
      folder.features << KML::Placemark.new(
        :name => name,
        :geometry => KML::Point.new(:coordinates => {:lat => lat, :lng => lng})
      )
    end
    kml.objects << folder
    puts kml.render
