require "test_helper"

class ExtractSubparamTest < ActiveSupport::TestCase
  
  test '.call should extract sub-param' do
    #given
    params = ActionController::Parameters.new(user: {foo: 'bar', name: 'baz'})
    #when
    result = ExtractSubparam.new.call(params, :user, :foo)
    #then
    assert_equal('bar', result)
  end

  test '.call should extract sub-param, other test' do
    #given
    params = ActionController::Parameters.new(user: {foo: 'bar', name: 'baz'})
    #when
    result = ExtractSubparam.new.call(params, :user, :name)
    #then
    assert_equal('baz', result)
  end

end
