require "test_helper"

class PullAskerFromSessionTest < ActiveSupport::TestCase

  test ".call pull asker from session hash" do
    #given
    session_h = {asker: '{"v_age": 42}'}
    #when
    res = PullAskerFromSession.new.call(session_h)
    #then
    assert_equal true, res.is_a?(Asker)
    assert_equal true, res.v_age == "42"
  end

end
