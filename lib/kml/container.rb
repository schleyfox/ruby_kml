module KML
  # A Container is an abstract base class that holds one or more Features and allows the creation of nested hierarchies.
  class Container < Feature
    
    # Access the features in the container
    attr_accessor :features
    
    # Get the features in the container
    def features
      @features ||= []
    end
  end
end

require 'kml/folder'
require 'kml/document'