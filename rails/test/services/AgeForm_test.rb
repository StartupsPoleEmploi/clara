require "test_helper"

class AgeFormTest < ActiveSupport::TestCase

  test "nominal : valid age" do
    #given
    age_form = AgeForm.new(number_of_years: 42)
    #when
    age_form.valid?
    #then
    assert_equal([], age_form.errors.errors)
  end

  test "bad : void age" do
    #given
    age_form = AgeForm.new
    #when
    age_form.valid?
    #then
    assert_equal(:age_must_be_present, age_form.errors.errors[0].attribute)
  end

  test "bad : age too small" do
    #given
    age_form = AgeForm.new(number_of_years: 15)
    #when
    age_form.valid?
    #then
    assert_equal(:age_must_be_greater_than_16, age_form.errors.errors[0].attribute)
  end

  test "bad : age too high" do
    #given
    age_form = AgeForm.new(number_of_years: 75)
    #when
    age_form.valid?
    #then
    assert_equal(:age_must_be_lower_than_70, age_form.errors.errors[0].attribute)
  end

end
