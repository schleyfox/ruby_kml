h2. Divergence from schleyfox's branch

<pre>
A number of the classes were missing the <code>render</code> method, which prevented me from generating KML files with LookAt nodes. I've fixed what I needed, but can't speak for the functionality of all the other possible XML nodes.

-kdonovan
</pre>



h2. Documentation

Library for generating KML(Keyhole Markup Language) files in Ruby.
Sweet if you want to place markers, overlays, and other awesome things over a google map or google earth.

h2. Install

<pre><code>gem install schleyfox-ruby_kml --source http://gems.github.com</code></pre>

h2. Examples

See @test/kml_file_test.rb@ for more examples

h3. Placing markers on a map

"View on Google Maps":http://maps.google.com/maps?q=http://github.com/xaviershay/ruby_kml/tree/master%2Fexamples%2Fmelbourne-stations.kml?raw=true&t=k

<pre><code>require 'kml'

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
</code></pre>
