require "test_helper"

class NavigationTest < ActiveSupport::TestCase
  
  test '.admin_clazz returns "navigation__link navigation__link--active" is path is active' do
    #given
    active_path = "admin_users_path"
    allow_any_instance_of(GetCurrentPathService).to receive(:call).and_return(active_path)
    navigation = Navigation.new(OpenStruct.new(request: ""), nil)
    #when
    res = navigation.admin_clazz
    #then
    assert_equal(
      'navigation__link navigation__link--active', 
      res
    )
  end

  test '.admin_clazz returns "navigation__link navigation__link--inactive" is path is NOT active' do
    #given
    inactive_path = "inactive_path"
    allow_any_instance_of(GetCurrentPathService).to receive(:call).and_return(inactive_path)
    navigation = Navigation.new(OpenStruct.new(request: ""), nil)
    #when
    res = navigation.admin_clazz
    #then
    assert_equal(
      'navigation__link navigation__link--inactive', 
      res
    )
  end

  test '.filter_clazz returns "navigation__link navigation__link--active" is path is active' do
    #given
    active_path = "admin_filter_path"
    allow_any_instance_of(GetCurrentPathService).to receive(:call).and_return(active_path)
    navigation = Navigation.new(OpenStruct.new(request: ""), nil)
    #when
    res = navigation.filter_clazz
    #then
    assert_equal(
      'navigation__link navigation__link--active', 
      res
    )
  end

  test '.filter_clazz returns "navigation__link navigation__link--inactive" is path is NOT active' do
    #given
    inactive_path = "inactive_path"
    allow_any_instance_of(GetCurrentPathService).to receive(:call).and_return(inactive_path)
    navigation = Navigation.new(OpenStruct.new(request: ""), nil)
    #when
    res = navigation.filter_clazz
    #then
    assert_equal(
      'navigation__link navigation__link--inactive', 
      res
    )
  end

end
