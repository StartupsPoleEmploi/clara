require "test_helper"

class SvgFileFieldTest < ActiveSupport::TestCase
  
  test '.to_s displays data as String' do
    #given
    #when
    res = SvgFileField.new(nil, 'some data', nil).to_s
    #then
    assert_equal('some data', res)
  end

end
