$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
require 'pp'
require 'test/unit'

require 'kml'

class Test::Unit::TestCase
  def write_and_show(kml, file)
    #puts kml.render
    File.open(file, 'w') { |f| f.write kml.render }
    show_file(file)
  end

  def show_file(file)
    #tests should probably not launch visual external applications
    #cmd = "open -a /Applications/Google\\ Earth.app/ #{File.expand_path(file)}"
    #puts "executing command: #{cmd}"
    #`#{cmd}`
  end
end
