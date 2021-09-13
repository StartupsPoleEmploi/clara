require "test_helper"
    
class CreateStage5Test < ActiveSupport::TestCase

  test ".call, nominal" do
    #given
    slug = 'a'
    action_asked = 'b'
    #when
    res = CreateStage5.new.call(slug, action_asked)
    #then
    assert_equal('foo', res)
  end

end

