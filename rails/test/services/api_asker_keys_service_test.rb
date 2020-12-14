require "test_helper"
    
class ApiAskerKeysServiceTest < ActiveSupport::TestCase

  test ".asker_hash, nominal" do
    #given
    #when
    res = ApiAskerKeysService.new.asker_hash
    #then
    assert res.is_a?(Hash)
  end

end
