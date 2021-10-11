require "test_helper"
    
class FindScopeAndGeoErrorsTest < ActiveSupport::TestCase

  test ".call, default" do
    #given
    #when
    res = FindScopeAndGeoErrors.new.call(_default_trundle, _default_geo)
    #then
    assert_equal "Étape non renseignée.", res
  end

  test ".call, geo only" do
    #given
    #when
    res = FindScopeAndGeoErrors.new.call(_default_trundle, _valid_geo)
    #then
    assert_equal "Il n'est pas possible d'indiquer un critère géographique seulement.", res
  end

  test ".call, editing trundle, valid geo" do
    #given
    #when
    res = FindScopeAndGeoErrors.new.call(_editing_trundle, _valid_geo)
    #then
    assert_equal "Vous avez commencé à renseigner une condition, merci de terminer votre action ou de l'annuler", res
  end

  test ".call, valid trundle, invalid geo" do
    #given
    #when
    res = FindScopeAndGeoErrors.new.call(_valid_trundle, _invalid_geo)
    #then
    assert_equal "Il faut à minima renseigner une ville, ou un département, ou une région pour cette sélection géographique.", res
  end

  def _default_trundle
    {
              :name => "root_box",
    :subcombination => "",
          :subboxes => [
        {
                      :name => "box_1633945118998",
            :subcombination => "",
                  :subboxes => [],
                      :xval => "",
                       :xop => "",
                      :xvar => "",
                      :xtxt => "",
                :is_editing => true
        }
    ]
}
  end

  def _default_geo
    {
     :selection => "tout",
          :town => [],
    :department => [],
        :region => []
    }
  end

  def _valid_geo
    {
     :selection => "tout_sauf_domtom",
          :town => [],
    :department => [],
        :region => []
    }
  end
  def _invalid_geo
    {
     :selection => "tout_sauf",
          :town => [],
    :department => [],
        :region => []
    }
  end

  def _editing_trundle
    {
              :name => "root_box",
    :subcombination => "OR",
          :subboxes => [
            {
                      :name => "box_1633945140999",
            :subcombination => "",
                  :subboxes => [],
                      :xval => "non",
                       :xop => "equal",
                      :xvar => "v_handicap",
                      :xtxt => "Ne pas être en situation de handicap",
                :is_editing => false
            },
            {
                      :name => "box_1633945167028",
            :subcombination => "",
                  :subboxes => [],
                      :xval => "",
                       :xop => "",
                      :xvar => "",
                      :xtxt => "",
                :is_editing => true
          }
        ]
    }
  end
  def _valid_trundle
    {
              :name => "root_box",
    :subcombination => "OR",
          :subboxes => [
            {
                      :name => "box_1633945140999",
            :subcombination => "",
                  :subboxes => [],
                      :xval => "non",
                       :xop => "equal",
                      :xvar => "v_handicap",
                      :xtxt => "Ne pas être en situation de handicap",
                :is_editing => false
            },
            {
                      :name => "box_1633945167028",
            :subcombination => "",
                  :subboxes => [],
                      :xval => "18",
                       :xop => "equal",
                      :xvar => "age",
                      :xtxt => "Avoir exactement 18 ans",
                :is_editing => false
          }
        ]
    }
  end

end

