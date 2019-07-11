require "test_helper"

class NavigationTest < ActiveSupport::TestCase
  
  test '.admin_clazz returns "navigation__link navigation__link--active" is path is active' do
    res = Navigation.new(nil, nil)
    assert_equal(
      'navigation__link navigation__link--active', 
      res.admin_clazz
    )
  end

end
