require "test_helper"

class NavigationTest < ActiveSupport::TestCase
  
  test '.admin_clazz returns "navigation__link navigation__link--active" is path is active' do
    #given
    active_path = "admin_users_path"
    allow_any_instance_of(GetCurrentPathService).to receive(:call).and_return(active_path)
    #when
    res = Navigation.new(OpenStruct.new(request: ""), nil)
    #then
    assert_equal(
      'navigation__link navigation__link--active', 
      res.admin_clazz
    )
  end

  test '.admin_clazz returns "navigation__link navigation__link--inactive" is path is NOT active' do
    #given
    inactive_path = "inactive_path"
    allow_any_instance_of(GetCurrentPathService).to receive(:call).and_return(inactive_path)
    #when
    res = Navigation.new(OpenStruct.new(request: ""), nil)
    #then
    assert_equal(
      'navigation__link navigation__link--inactive', 
      res.admin_clazz
    )
  end

end
