require "test_helper"

class CalculateAskerServiceTest < ActiveSupport::TestCase

  test '.calculate_zrr! should update zrr field' do
    #given
    asker = Asker.new
    asker.v_location_citycode = "59606"
    assert_nil(asker.v_zrr)
    allow_any_instance_of(IsZrr).to receive(:call).with("59606").and_return("est_en_zrr")
    #when
    CalculateAskerService.new(asker).calculate_zrr!
    #then
    assert_equal("est_en_zrr", asker.v_zrr)
  end
end
