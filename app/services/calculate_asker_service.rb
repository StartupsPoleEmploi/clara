
class CalculateAskerService
  
  def initialize(asker)
    @asker = asker
  end

  def calculate_zrr
    if @asker.v_location_citycode
      @asker.v_zrr = ZrrService.new.zrr?(@asker.v_location_citycode) 
    end
  end
end
