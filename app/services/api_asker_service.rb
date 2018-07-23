
class ApiAskerService
  
  def initialize(english_asker_attr)
    @english_asker = english_asker_attr.is_a?(Hash) ? english_asker_attr.symbolize_keys : {}
  end

  def to_asker
    asker = ApiAsker.new
    asker.v_spectacle                 = @english_asker[:spectacle]
    asker.v_handicap                  = @english_asker[:disabled]
    asker.v_diplome                   = @english_asker[:diploma]
    asker.v_category                  = @english_asker[:category]
    asker.v_duree_d_inscription       = @english_asker[:inscription_period]
    asker.v_allocation_type           = @english_asker[:allocation_type]
    asker.v_allocation_value_min      = @english_asker[:monthly_allocation_value]
    asker.v_age                       = @english_asker[:age]
    asker.v_location_citycode         = @english_asker[:location_citycode]
    asker
  end
  

end
