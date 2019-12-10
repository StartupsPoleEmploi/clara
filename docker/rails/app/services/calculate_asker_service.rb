
class CalculateAskerService
  
  def initialize(asker)
    @asker = asker
  end

  def calculate_zrr!
    @asker.v_zrr = IsZrr.new.call(@asker.v_location_citycode)
    @asker
  end
end
