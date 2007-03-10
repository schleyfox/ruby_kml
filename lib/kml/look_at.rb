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
  end
end