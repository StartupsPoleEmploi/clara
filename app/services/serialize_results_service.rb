
class SerializeResultsService

  class << self
    protected :new
  end
  
  @@the_double = nil

  # Allow DI for testing purpose
  def SerializeResultsService.set_instance(the_double)
    @@the_double = the_double
  end

  def SerializeResultsService.get_instance
    @@the_double.nil? ? SerializeResultsService.new : @@the_double
  end

  def go(asker)

    calculator = AidCalculationService.get_instance(asker)
    res =  {
     flat_all_eligible: calculator.every_eligible,
     flat_all_uncertain: calculator.every_uncertain,
     flat_all_ineligible: calculator.every_ineligible,
     flat_all_contract: ActivatedModelsService.get_instance.contract_types,
     flat_all_filter: ActivatedModelsService.get_instance.filters,
     asker: asker.attributes
    }
    res
  end

  def api_eligible(asker, filters)
    calculator = AidCalculationService.get_instance(asker)
    result = {
      aids: whitelist(filter(calculator.every_eligible, filters))
    }
    result
  end

  def api_ineligible(asker)
    calculator = AidCalculationService.get_instance(asker)
    result = {
      aids: whitelist(calculator.every_ineligible)
    }
    result
  end

  def api_uncertain(asker)
    calculator = AidCalculationService.get_instance(asker)
    result = {
      aids: whitelist(calculator.every_uncertain)
    }
    result
  end

private
  def whitelist(aids)
    aids.map {|aid| WhitelistAidService.new.for_aid_in_list(aid)}
  end

  def filter(elies, filters)
    a = ActivatedModelsService.get_instance
    filters_array = filters.split(",")
    p '- - - - - - - - - - - - - - filters_array- - - - - - - - - - - - - - - -' 
    pp filters_array
    p ''
    elies.select do |ely| 
      boolean_result = !ely["filters"].empty?
      current_filter_array = ely["filters"].map do |ely_filter|
        a.filters.find{|active_filter| active_filter["id"] == ely_filter["id"]}["slug"]
      end
      p '- - - - - - - - - - - - - - current_filter_array- - - - - - - - - - - - - - - -' 
      pp current_filter_array
      p ''
      intersection_array = current_filter_array & filters_array
      p '- - - - - - - - - - - - - - intersection_array- - - - - - - - - - - - - - - -' 
      pp intersection_array
      p ''
      !intersection_array.empty?
    end
    # p '- - - - - - - - - - - - - - elies- - - - - - - - - - - - - - - -' 
    # pp elies
    # p ''
    # a = ActivatedModelsService.get_instance
    # filters_array = filters.split(",")
    # p '- - - - - - - - - - - - - - filters_array- - - - - - - - - - - - - - - -' 
    # pp filters_array
    # p ''
    # elies.select do |ely|
    #   # p '- - - - - - - - - - - - - - ely- - - - - - - - - - - - - - - -' 
    #   # pp ely
    #   # pp ely["filters"]
    #   # pp ely["filters"].empty?
    #   # p ''
    #   # return false if ely["filters"].empty?
    #   # current_filter_array = ely["filters"].map do |ely_filter| 
    #   #   a.filters.find{|active_filter| active_filter["id"] == ely_filter["id"]}["slug"]
    #   # end
    #   # p '- - - - - - - - - - - - - - current_filter_array- - - - - - - - - - - - - - - -' 
    #   # pp current_filter_array
    #   # p ''
    #   # intersection_array = current_filter_array & filters_array
    #   # p '- - - - - - - - - - - - - - intersection_array- - - - - - - - - - - - - - - -' 
    #   # pp intersection_array
    #   # p ''
    #   # return !intersection_array.empty?
    #   return true
    # end
    # p '- - - - - - - - - - - - - - filters- - - - - - - - - - - - - - - -' 
    # pp filters_array
    # p ''
    # p '- - - - - - - - - - - - - - elies- - - - - - - - - - - - - - - -' 
    # pp elies
    # p ''
    # elies
  end

end
