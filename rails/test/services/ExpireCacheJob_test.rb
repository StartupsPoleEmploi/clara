require "test_helper"

class ExpireCacheJobTest < ActiveSupport::TestCase

  test ".perform calls ExpireCache" do
    #given
    allow_any_instance_of(ExpireCache).to receive(:call).and_return("42")
    #when
    res = ExpireCacheJob.new.perform
    #then
    assert_equal("42", res)
  end

end
