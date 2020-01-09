require "test_helper"

class HydrateAddressTest < ActiveSupport::TestCase
  def setup
    _fake_is_zrr
    _fake_get_city_name
  end

  test "Raise an error if arg is not a asker attributes hash" do
    assert_raises(ArgumentError) { HydrateAddress.new.call(//) }
  end

  test "Returns an asker" do
    subject = HydrateAddress.new.call(Asker.new.attributes)
    assert(subject.is_a?(Asker))
  end

  test "Returns an asker with same attributes if citycode is not here" do
    asker = Asker.new(v_location_zipcode: "59440")
    returned_asker = HydrateAddress.new.call(asker.attributes)
    assert_equal(returned_asker.attributes, asker.attributes)
  end

  test "Returns an asker with fulfilled geo attributes if both citycode and zipcode are here" do
    asker = Asker.new(v_location_zipcode: "59440", v_location_citycode: "59035")
    returned_asker = HydrateAddress.new.call(asker.attributes)
    h = returned_asker.attributes
    assert_equal(h["v_location_city"], "Avesnelles")
    assert_equal(h["v_location_label"], "59440 Avesnelles")
    assert_equal(h["v_location_zipcode"], "59440")
    assert_equal(h["v_zrr"], "oui")
  end

  def _fake_is_zrr
    allow_any_instance_of(IsZrr).to receive(:call).and_return("oui")
  end

  def _fake_get_city_name
    allow_any_instance_of(GetCityName).to receive(:call).and_return("Avesnelles")
  end
end
