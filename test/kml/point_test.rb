require "#{File.dirname(__FILE__)}/../test_helper"

class KML::PointTest < Test::Unit::TestCase
  include KML

  def test_allows_coordinates_to_be_specified_with_a_hash
    point = Point.new(:coordinates => {:lat => 10, :lng => 20, :alt => 30})
    assert_equal [20, 10, 30], point.coordinates
  end
end
