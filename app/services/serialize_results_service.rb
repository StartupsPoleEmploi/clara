
class SerializeResultsService

  class << self
    protected :new
  end
  
  @@the_double = nil

  def SerializeResultsService.get_instance
    @@the_double.nil? ? SerializeResultsService.new : @@the_double
  end

  def go(asker)

    calculator = AidCalculationService.get_instance(asker)
    res =  {
     flat_all_eligible: calculator.every_eligible,
     flat_all_uncertain: calculator.every_uncertain,
     flat_all_ineligible: calculator.every_ineligible,
     # Deliberately NOT using ActivatedModelsService.instance.contracts, too much data are missing to display icons, description, etc
     flat_all_contract: JSON.parse(Rails.cache.fetch("contract_types") {ContractType.all.to_json}),
     # Deliberately NOT using ActivatedModelsService.instance.filters, too much data are missing also
     flat_all_filter: JSON.parse(Rails.cache.fetch("filters") {Filter.all.to_json(:only => [ :id, :slug, :name, :description ])}),
     asker: asker.attributes
    }
    res
  end

  def api_eligible(asker, filters, level3_filters)
    calculator = AidCalculationService.get_instance(asker)
    whitelist(filter(calculator.every_eligible, filters, level3_filters))
  end

  def api_ineligible(asker, filters)
    calculator = AidCalculationService.get_instance(asker)
    whitelist(filter(calculator.every_ineligible, filters))
  end

  def api_uncertain(asker, filters)
    calculator = AidCalculationService.get_instance(asker)
    whitelist(filter(calculator.every_uncertain, filters))
  end

private
  def whitelist(aids)
    aids.map {|aid| WhitelistAidService.new.for_aid_in_list(aid)}
  end

  def filter(elies, filters, level3_filters)

    non_empty_filters = filters.is_a?(String) && !filters.empty?
    non_empty_level3_filters = level3_filters.is_a?(String) && level3_filters.empty?

    active = ActivatedModelsService.instance

    # Regular filter    
    if non_empty_filters
      filters_array = filters.split(",")
      elies.select do |ely|
        ely["filters"] = [] if ely["filters"] == nil
        current_filter_array = ely["filters"].map do |ely_filter|
          active.filters.find{|active_filter| active_filter["id"] == ely_filter["id"]}["slug"]
        end
        intersection_array = current_filter_array & filters_array
        !intersection_array.empty?
      end
    end

    # Level3 filter    
    if non_empty_level3_filters
      level3_filters_array = level3_filters.split(",")
      elies.select do |ely|
        ely["level3_filters"] = [] if ely["level3_filters"] == nil
        current_filter_array = ely["level3_filters"].map do |ely_filter|
          active.level3_filters.find{|active_filter| active_filter["id"] == ely_filter["id"]}["slug"]
        end
        intersection_array = current_filter_array & level3_filters_array
        !intersection_array.empty?
      end
    end


    elies
  end

end
