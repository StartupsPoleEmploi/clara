
class CalculateAskerService
  
  def initialize(asker)
    @asker = asker
  end

  def calculate_zrr!
    @asker.v_zrr = ZrrService.new.zrr?(@asker.v_location_citycode) 
    @asker
  end
end
