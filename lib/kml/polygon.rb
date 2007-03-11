# Source file which generates a Polygon element.
#
# <Polygon id="ID">
#   <!-- specific to Polygon -->
#   <extrude>0</extrude>                       <!-- boolean -->
#   <tessellate>0</tessellate>                 <!-- boolean -->
#   <altitudeMode>clampToGround</altitudeMode> 
#     <!-- kml:altitudeModeEnum: clampToGround, relativeToGround, or absolute -->
#   <outerBoundaryIs>
#     <LinearRing>
#       <coordinates>...</coordinates>         <!-- lon,lat[,alt] -->
#     </LinearRing>
#   </outerBoundaryIs>
#   <innerBoundaryIs>
#     <LinearRing>
#       <coordinates>...</coordinates>         <!-- lon,lat[,alt] -->
#     </LinearRing>
#   </innerBoundaryIs>
# </Polygon>

module KML #:nodoc:
  # A Polygon is defined by an outer boundary and 0 or more inner boundaries. The boundaries, in turn, are defined 
  # by LinearRings. When a Polygon is extruded, its boundaries are connected to the ground to form additional polygons, 
  # which gives the appearance of a building. When a Polygon is extruded, each point is extruded individually. 
  # Extruded Polygons use PolyStyle for their color, color mode, and fill.
  class Polygon < Geometry
    attr_accessor :inner_boundary_is
    attr_accessor :outer_boundary_is
    
    def render(xm=Builder::XmlMarkup.new(:indent => 2))
      xm.Polygon {
        super
        xm.outerBoundaryIs {
          outer_boundary_is.render(xm)
        }
        xm.innerBoundaryIs {
          inner_boundary_is.render(xm)
        }
      }
    end
  end
end