
class CalculateAskerService
  
  def initialize(asker)
    @asker = asker
  end

  def calculate_zrr!
    @asker.v_zrr = IsZrr.call(citycode: @asker.v_location_citycode)
    @asker
  end
end
