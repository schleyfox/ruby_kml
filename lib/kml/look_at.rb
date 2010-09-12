# <LookAt id="ID">
#   <longitude></longitude>      <!-- kml:angle180 -->
#   <latitude></latitude>        <!-- kml:angle90 -->
#   <altitude>0</altitude>       <!-- double --> 
#   <range></range>              <!-- double -->
#   <tilt>0</tilt>               <!-- float -->
#   <heading>0</heading>         <!-- float -->
#   <altitudeMode>clampToGround</altitudeMode> 
#     <!--kml:altitudeModeEnum:clampToGround, relativeToGround, absolute -->
# </LookAt>
module KML
  class LookAt < KML::Object
    attr_accessor :longitude
    attr_accessor :latitude
    attr_accessor :altitude
    attr_accessor :range
    attr_accessor :tilt
    attr_accessor :heading
    attr_accessor :altitude_mode
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      [:longitude, :latitude, :altitude, :range, :tilt, :heading, :altitude_mode].each do |a|
        xm.__send__(a, self.__send__(a)) unless self.__send__(a).nil?
      end
    end
    
  end
end