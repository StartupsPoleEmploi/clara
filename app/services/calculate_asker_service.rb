
class CalculateAskerService
  
  def initialize(asker)
    @asker = asker
  end

  def calculate_zrr_qpv
    QpvService.get_instance.setDetailedQPV(@asker.v_location_street_number, @asker.v_location_route, @asker.v_location_zipcode, @asker.v_location_city)
    
    if @asker.v_location_street_number
      @asker.v_qpv = QpvService.get_instance.isDetailedQPV(@asker.v_location_street_number, @asker.v_location_route, @asker.v_location_zipcode, @asker.v_location_city)
    end

    if @asker.v_location_citycode
      @asker.v_zrr = ZrrService.get_instance.isZRR(@asker.v_location_citycode) 
    end
  end
end
