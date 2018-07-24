
class ApiAskerService
  
  def initialize(english_asker_attr)
    @english_asker = english_asker_attr.is_a?(Hash) ? english_asker_attr.symbolize_keys : {}
  end

  def to_api_asker
    debug_value = "ddebugg"
    asker = ApiAsker.new
    debug_mode = false
    debug_mode = @english_asker.any? { |key, value| value.include?(debug_value) }
    asker.v_spectacle                 = @english_asker[:spectacle].chomp(debug_value) if @english_asker[:spectacle] != nil
    asker.v_handicap                  = @english_asker[:disabled].chomp(debug_value) if @english_asker[:disabled] != nil
    asker.v_diplome                   = @english_asker[:diploma].chomp(debug_value) if @english_asker[:diploma] != nil
    asker.v_category                  = @english_asker[:category].chomp(debug_value) if @english_asker[:category] != nil
    asker.v_duree_d_inscription       = @english_asker[:inscription_period].chomp(debug_value) if @english_asker[:inscription_period] != nil
    asker.v_allocation_type           = @english_asker[:allocation_type].chomp(debug_value) if @english_asker[:allocation_type] != nil
    asker.v_allocation_value_min      = @english_asker[:monthly_allocation_value].chomp(debug_value) if @english_asker[:monthly_allocation_value] != nil
    asker.v_age                       = @english_asker[:age].chomp(debug_value) if @english_asker[:age] != nil
    asker.v_location_citycode         = @english_asker[:location_citycode].chomp(debug_value) if @english_asker[:location_citycode] != nil
    [asker, debug_mode]
  end
  

end
