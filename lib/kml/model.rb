module KML
  class Model < Geometry

    def initialize(params={})
      @lng, @lat, @alt = *params[:location]
      @heading, @tilt, @roll = *params[:orientation] || [0, 0, 0]
      @x, @y, @z = *params[:scale] || [1, 1, 1]
      @link = params[:link]
      @id = params[:id] if params[:id]
    end

    def id
      @id || "model_#{@link.href}_#{@x}_#{@y}"
    end

    def render(xm = Builder::XmlMarkup.new(:indent => 2))
      xm.Model :id => id do
        xm.altitudeMode(altitude_mode) if altitude_mode_set?
        xm.Location do
          xm.longitude @lng
          xm.latitude  @lat
          xm.altitude  @alt
        end
        xm.Orientation do
          xm.heading @heading
          xm.tilt    @tilt
          xm.roll    @roll
        end
        xm.Scale do
          xm.x @x
          xm.y @y
          xm.z @z
        end
        @link.render(xm)
        # ResourceMap needs to be implemented still
      end
    end

  end
end
