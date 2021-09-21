require "test_helper"

class ExtractGeoForAidTest < ActiveSupport::TestCase
  
  test '._fill_simple will fill simple rule' do
    #given
    rule = Rule.new({
                name: "r_hcsimbatodgpvukr_citycode_not_equal_54395_id_28247388393174677",
      value_eligible: "54395",
         description: "Ne pas résider à Nancy 54",
                kind: "simple",
       operator_kind: "not_equal",
    })
    #when
    res = ExtractGeoForAid.new._fill_simple(rule)
    #then
    assert_equal({"selection"=>"tout_sauf", "town"=>[{"54395"=>"Nancy 54"}], "department"=>[], "region"=>[]}, res)
  end

  test '._fill will fill complex rules, tout' do
    #given
    #when
    res = ExtractGeoForAid.new._fill(_tout_sauf_rules)
    #then
    assert_equal({"selection"=>"tout_sauf", "town"=>[{"54395"=>"Nancy 54"}], "department"=>[{"03"=>"03 Allier"}], "region"=>[{"ARA"=>"Auvergne-Rhône-Alpes"}]}, res)
  end

  test '._fill will fill complex rules, rien' do
    #given
    #when
    res = ExtractGeoForAid.new._fill(_rien_sauf_rules)
    #then
    assert_equal({"selection"=>"rien_sauf", "town"=>[{"54395"=>"Nancy 54"}], "department"=>[{"03"=>"03 Allier"}], "region"=>[{"ARA"=>"Auvergne-Rhône-Alpes"}]}, res)
  end

  test '._fill will detect DOMTOM' do
    #given
    #when
    res = ExtractGeoForAid.new._fill(_domtom_only_rules)
    #then
    assert_equal({"selection"=>"tout_sauf_domtom", "town"=>[], "department"=>[], "region"=>[]}, res)
  end

  def _tout_sauf_rules
    [
      Rule.new({
                      name: "r_ixkcuzrtwvajosdn_citycode_not_equal_54395_id_9929022358879638",
            value_eligible: "54395",
               description: "Ne pas résider à Nancy 54",
                      kind: "simple",
             operator_kind: "not_equal"
      }),
      Rule.new({
                      name: "r_ixkcuzrtwvajosdn_department_not_starts_with_03_id_8276661275728657",
            value_eligible: "03",
               description: "Ne pas résider dans le département 03 Allier",
                      kind: "simple",
             operator_kind: "not_starts_with"
      }),
      Rule.new({
                      name: "r_ixkcuzrtwvajosdn_region_not_starts_with_auvergne-rhone-alpes_id_26737667975437485",
            value_eligible: "Auverg",
               description: "Ne pas résider dans la région Auvergne-Rhône-Alpes",
                      kind: "simple",
             operator_kind: "not_starts_with"
      })
    ]
  end

  def _rien_sauf_rules
    [
      Rule.new({
                      name: "r_nzkrlawcqdgbvepo_citycode_equal_54395_id_9008029039186354",
            value_eligible: "54395",
               description: "Résider à Nancy 54",
                      kind: "simple",
             operator_kind: "equal",
      }),
      Rule.new({
                      name: "r_nzkrlawcqdgbvepo_department_starts_with_03_id_5390533158465547",
            value_eligible: "03",
               description: "Résider dans le département 03 Allier",
                      kind: "simple",
             operator_kind: "starts_with",
      }),
      Rule.new({
                      name: "r_nzkrlawcqdgbvepo_region_starts_with_auvergne-rhone-alpes_id_8196167033653389",
            value_eligible: "Auverg",
               description: "Résider dans la région Auvergne-Rhône-Alpes",
                      kind: "simple",
             operator_kind: "starts_with",
      })
    ]
  end

  def _domtom_only_rules
    [
      Rule.new({
                      name: "r_pezwnldgrohuvxbj_department_not_starts_with_971_id_5420264700752937",
            value_eligible: "971",
               description: "Ne pas résider dans le département Guadeloupe",
                      kind: "simple",
             operator_kind: "not_starts_with",
      }),
      Rule.new({
                      name: "r_pezwnldgrohuvxbj_department_not_starts_with_972_id_3016571027086793",
            value_eligible: "972",
               description: "Ne pas résider dans le département Martinique",
                      kind: "simple",
             operator_kind: "not_starts_with",
      }),
      Rule.new({
                      name: "r_pezwnldgrohuvxbj_department_not_starts_with_973_id_19206413033250647",
            value_eligible: "973",
               description: "Ne pas résider dans le département Guyane",
                      kind: "simple",
             operator_kind: "not_starts_with",
      }),
      Rule.new({
                      name: "r_pezwnldgrohuvxbj_department_not_starts_with_974_id_5266185083746124",
            value_eligible: "974",
               description: "Ne pas résider dans le département La Réunion",
                      kind: "simple",
             operator_kind: "not_starts_with",
      }),
      Rule.new({
                      name: "r_pezwnldgrohuvxbj_department_not_starts_with_975_id_05938534393077488",
            value_eligible: "975",
               description: "Ne pas résider dans le département Saint-Pierre-et-Miquelon",
                      kind: "simple",
             operator_kind: "not_starts_with",
      }),
      Rule.new({
                      name: "r_pezwnldgrohuvxbj_department_not_starts_with_976_id_7216063259737636",
            value_eligible: "976",
               description: "Ne pas résider dans le département Mayotte",
                      kind: "simple",
             operator_kind: "not_starts_with",
      })
    ]
  end

end
