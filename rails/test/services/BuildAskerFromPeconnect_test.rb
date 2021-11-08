require "test_helper"
    
class BuildAskerFromPeconnectTest < ActiveSupport::TestCase

  test "._actual_inscrit, wrong input" do
    #given
    val = 'any'
    #when
    res = BuildAskerFromPeconnect.new._actual_inscrit(val)
    #then
    assert_equal '', res
  end

  test "._actual_inscrit, 0 value" do
    #given
    val = '0'
    #when
    res = BuildAskerFromPeconnect.new._actual_inscrit(val)
    #then
    assert_equal 'en_recherche', res
  end


  test "._actual_inscrit, 1 value" do
    #given
    val = '1'
    #when
    res = BuildAskerFromPeconnect.new._actual_inscrit(val)
    #then
    assert_equal 'oui', res
  end



end

