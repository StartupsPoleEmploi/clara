
class TranslateAskerService
  
  def initialize(english_asker)
    @english_asker = english_asker.is_a?(Hash) ? english_asker.symbolize_keys : {}
  end

  def to_french
    asker = Asker.new

    asker.v_harki = @english_asker[:harki] == "true" ? "oui" : @english_asker[:harki] == "false" ? "non" : nil
    asker.v_handicap = @english_asker[:disabled] == "true" ? "oui" : @english_asker[:disabled] == "false" ? "non" : nil
    asker.v_detenu = @english_asker[:ex_invict] == "true" ? "oui" : @english_asker[:ex_invict] == "false" ? "non" : nil
    asker.v_protection_internationale = @english_asker[:international_protection] == "true" ? "oui" : @english_asker[:international_protection] == "false" ? "non" : nil



    asker
  end
  
  def diploma_to_french(diploma)
    {level_1: "niveau_1", level_2: "niveau_2", level_3: "niveau_3", level_4: "niveau_4", level_5: "niveau_5"}
  end

  def other_to_french(other)
    {true: "oui", false: "non"}[other.to_sym]
  end

end
