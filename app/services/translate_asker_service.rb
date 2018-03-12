
class TranslateAskerService
  
  def initialize(english_asker)
    @english_asker = english_asker.is_a?(Hash) ? english_asker.symbolize_keys : {}
  end

  def to_french
    asker = Asker.new

    asker.v_harki = @english_asker[:harki] == "true" ? "oui" : @english_asker[:harki] == "false" ? "non" : nil

    asker
  end
  
end
