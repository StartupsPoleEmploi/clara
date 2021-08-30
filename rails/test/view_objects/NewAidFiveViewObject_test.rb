require "test_helper"

class NewAidFiveViewObjectTest < ActiveSupport::TestCase
  

  test "reread_h default value" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    #when
    res = sut.reread_h
    #then
    assert_equal({:class=>"c-newbutton c-newaid-actionrecord js-askforreread", :disabled=>"disabled"}, res)
  end
 
  test "reread_h could be disabled is not all stages are ok" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    #when
    res = sut.reread_h
    #then
    assert_equal({:class=>"c-newbutton c-newaid-actionrecord js-askforreread", :disabled=>"disabled"}, res)
  end
 
  test "reread_h could remove the disabled property if all stages are ok" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    allow(sut).to receive(:_all_stages_ok?).and_return(true)
    #when
    res = sut.reread_h
    #then
    assert_equal({:class=>"c-newbutton c-newaid-actionrecord js-askforreread"}, res)
  end
 
 end
