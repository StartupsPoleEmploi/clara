
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
     flat_all_contract: JSON.parse(Rails.cache.fetch("contract_types") {ContractType.all.to_json}),
     flat_all_filter: JSON.parse(Rails.cache.fetch("filters") {Filter.all.to_json(:only => [ :id, :slug, :name, :description ])}),
     asker: asker.attributes
    }
    res
  end

  def api_eligible(asker, filters)
    calculator = AidCalculationService.get_instance(asker)
    whitelist(filter(calculator.every_eligible, filters))
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

  def filter(elies, filters)
    return elies unless filters.is_a?(String) && !filters.empty?
    a = ActivatedModelsService.instance
    filters_array = filters.split(",")
    elies.select do |ely|
      ely["filters"] = [] if ely["filters"] == nil
      current_filter_array = ely["filters"].map do |ely_filter|
        a.filters.find{|active_filter| active_filter["id"] == ely_filter["id"]}["slug"]
      end
      intersection_array = current_filter_array & filters_array
      !intersection_array.empty?
    end
  end

end
