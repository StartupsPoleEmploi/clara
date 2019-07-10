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
