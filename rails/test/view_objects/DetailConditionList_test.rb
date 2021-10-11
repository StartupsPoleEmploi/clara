require "test_helper"

class DetailConditionListTest < ActiveSupport::TestCase
  

  test ".html_output, nominal" do
    #given
    sut = DetailConditionList.new(nil, {ability_tree: _full_ability_tree})
    #when
    res = sut.html_output
    #then
    assert(res.include?("il faut réunir"))
  end

  test ".html_output, zero slave rule" do
    #given
    sut = DetailConditionList.new(nil, {ability_tree: _zero_slave_rule_ability_tree})
    #when
    res = sut.html_output
    #then
    assert(res.include?("il faut remplir la condition suivante"))
  end

  test ".html_output, ability_tree" do
    #given
    sut = DetailConditionList.new(nil, {ability_tree: {}})
    #when
    res = sut.html_output
    #then
    assert res.include?("Le champ d'application n'existe pas")
  end


  def _zero_slave_rule_ability_tree
    {
             ability: "eligible",
                name: "r_eghjcvndpmzqflyk_root_box",
    composition_type: "or_rule",
         slave_rules: []
    }
  end

  def _full_ability_tree
    {
        ability: "eligible",
        name: "r_eghjcvndpmzqflyk_root_box",
        description: nil,
        composition_type: "or_rule",
        slave_rules: [
          {
            ability: "eligible",
            name: "r_eghjcvndpmzqflyk_box_1574075780390b",
            description: "Être inscrit à Pôle Emploi",
            composition_type: "and_rule",
            slave_rules: [{
              ability: "ineligible",
              name: "r_eghjcvndpmzqflyk_box_1574075780390a",
              description: "À la recherche d'un emploi sans être inscrit à Pôle Emploi",
              composition_type: nil,
              slave_rules: []
            }]
          },

        ]
    }
  end

end

