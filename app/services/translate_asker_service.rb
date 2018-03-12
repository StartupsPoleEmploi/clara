
class TranslateAskerService
  
  def initialize(english_asker)
    @english_asker = english_asker.is_a?(Hash) ? english_asker.symbolize_keys : {}
  end

  def to_french
    asker = Asker.new

    asker.v_harki = other_to_french(@english_asker[:harki])
    asker.v_handicap = other_to_french(@english_asker[:disabled])
    asker.v_detenu = @english_asker[:ex_invict] == "true" ? "oui" : @english_asker[:ex_invict] == "false" ? "non" : nil
    asker.v_protection_internationale = @english_asker[:international_protection] == "true" ? "oui" : @english_asker[:international_protection] == "false" ? "non" : nil

    asker.v_diplome = diploma_to_french(@english_asker[:diploma])


    asker
  end
  
  def diploma_to_french(diploma)
    return unless diploma.is_a?(String)
    {level_1: "niveau_1", level_2: "niveau_2", level_3: "niveau_3", level_4: "niveau_4", level_5: "niveau_5", level_below_5: "niveau_infra_5"}[diploma.to_sym]
  end

  def other_to_french(other)
    return unless other.is_a?(String)
    {true: "oui", false: "non"}[other.to_sym]
  end

end
