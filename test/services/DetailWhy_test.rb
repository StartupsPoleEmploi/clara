require "test_helper"

class DetailWhyTest < ActiveSupport::TestCase
  
  test ".root_condition Should return root_condition available in args" do
    sut = DetailWhy.new(nil, nominal_args)
    assert_equal("or", sut.root_condition)
  end

  test ".ability Should return ability available in args" do
    sut = DetailWhy.new(nil, nominal_args)
    assert_equal("eligible", sut.ability)
  end

  test ".root_rules are sorted by eligible first if ability is eligible" do
    local_args = nominal_args
    local_args[:ability] = "eligible"
    sut = DetailWhy.new(nil, local_args)
    assert_equal("eligible", sut.root_rules[0][:status])
  end

  test ".root_rules are sorted by ineligible first if ability is ineligible" do
    local_args = nominal_args
    local_args[:ability] = "ineligible"
    sut = DetailWhy.new(nil, local_args)
    assert_equal("ineligible", sut.root_rules[0][:status])
  end

  test ".root_rules are sorted by uncertain first if ability is uncertain" do
    local_args = nominal_args
    local_args[:ability] = "uncertain"
    sut = DetailWhy.new(nil, local_args)
    assert_equal("uncertain", sut.root_rules[0][:status])
  end

  test ".root_rules returns empty array if ability is not amongst eligible, ineligible, uncertain" do
    local_args = nominal_args
    local_args[:ability] = "wronginput"
    sut = DetailWhy.new(nil, local_args)
    assert_equal([], sut.root_rules)
  end

  test ".uncertain_sentence returns empty string if ability is not uncertain" do
    local_args = nominal_args
    local_args[:ability] = "eligible"
    sut = DetailWhy.new(nil, local_args)
    assert_equal("", sut.uncertain_sentence)
  end

  test ".uncertain_sentence returns 'single-alone' if there is only one, lonely uncertain root_rule" do
    local_args = nominal_args
    local_args[:ability] = "uncertain"
    local_args[:root_rules] = [{:status => "uncertain", :name => "r_age_sup_16_et_age_inf_26", :description => "Avoir entre 16 et 26 ans"}]
    sut = DetailWhy.new(nil, local_args)
    assert_equal('single-alone', sut.uncertain_sentence)
  end

  test ".uncertain_sentence returns 'single-amongst' if there is only one uncertain root_rule amongst many" do
    local_args = nominal_args
    local_args[:ability] = "uncertain"
    local_args[:root_rules] = [
      {:status => "uncertain", :name => "r_age_sup_16_et_age_inf_26", :description => "Avoir entre 16 et 26 ans"},
      {:status => "eligible", :name => "r_ass_ou_rsa_ou_aah", :description => "Etre indemnisé/e au titre du RSA, de l'ASS ou de l'AAH"},
    ]
    sut = DetailWhy.new(nil, local_args)
    assert_equal('single-amongst', sut.uncertain_sentence)
  end

  def nominal_args
    {
      :ability => "eligible", 
      :root_condition => "or", 
      :root_rules => [
        {
          :status => "ineligible",
          :name => "r_age_sup_26_et_inscrit",
          :description => "Avoir plus de 26 ans et être inscrit/e à Pôle emploi"
        }, 
        {
          :status => "eligible",
          :name => "r_ass_ou_rsa_ou_aah",
          :description => "Etre indemnisé/e au titre du RSA, de l'ASS ou de l'AAH"
        }, 
        {
          :status => "uncertain",
          :name => "r_age_sup_16_et_age_inf_26",
          :description => "Avoir entre 16 et 26 ans"
        }
      ]
    }
  end

end
