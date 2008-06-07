Gem::Specification.new do |s|
  s.name = "ruby_kml"
  s.version = "0.1"
  s.date = "2008-06-07"
  s.summary = "Generate KML files with ruby"
  s.email  = ""
  s.homepage = "http://github.com/schleyfox/ruby_kml"
  s.description = "Generate KML files with ruby"
  s.has_rdoc = false
  s.authors = ["aeden, schleyfox, xaviershay"]
  s.files = ["CHANGELOG", "LICENSE", "Rakefile", "README.textile"] + %w(lib test).collect {|x| Dir["#{x}/**/*.rb"]}.flatten + Dir["examples/*.kml"]
  s.test_files = Dir["test/**/*.rb"]
end
