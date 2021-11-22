require "test_helper"

class ExpireCacheTest < ActiveSupport::TestCase
  
  test '.call will clear the cache' do
    #given
    expect(Rails.cache).to receive(:clear)
    #when
    result = ExpireCache.new.call
    #then
  end

end
