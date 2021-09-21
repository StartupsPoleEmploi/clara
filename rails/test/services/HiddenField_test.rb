require "test_helper"

class HiddenFieldTest < ActiveSupport::TestCase
  
  test '.to_s displays data as String' do
    #given
    #when
    res = HiddenField.new(nil, 'some data', nil).to_s
    #then
    assert_equal('some data', res)
  end

end
