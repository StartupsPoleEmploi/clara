
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
    _whitelist(_filter(calculator.every_eligible, filters, level3_filters))
  end

  def api_ineligible(asker, filters, level3_filters)
    calculator = AidCalculationService.get_instance(asker)
    _whitelist(_filter(calculator.every_ineligible, filters, level3_filters))
  end

  def api_uncertain(asker, filters, level3_filters)
    calculator = AidCalculationService.get_instance(asker)
    _whitelist(_filter(calculator.every_uncertain, filters, level3_filters))
  end

  def _whitelist(aids)
    aids.map {|aid| WhitelistAidService.new.for_aid_in_list(aid)}
  end

  def _filter(elies, filters, level3_filters, custom_filters=[], custom_parent_filters=[])
    # p '- - - - - - - - - - - - - - elies- - - - - - - - - - - - - - - -' 
    # pp elies
    # p ''
    # p '- - - - - - - - - - - - - - filters- - - - - - - - - - - - - - - -' 
    # pp filters
    # p ''
    # p '- - - - - - - - - - - - - - level3_filters- - - - - - - - - - - - - - - -' 
    # pp level3_filters
    # p ''

    has_regular_filters = filters.is_a?(String) && !filters.empty?
    has_level3_filters = level3_filters.is_a?(String) && !level3_filters.empty?

    active = ActivatedModelsService.instance
    # p '- - - - - - - - - - - - - - active.filters- - - - - - - - - - - - - - - -' 
    # pp active.filters
    # pp active.level3_filters
    # p ''

    regular_elies = []
    level3_elies = []

    # Regular filter    
    if has_regular_filters
      filters_array = filters.split(",")
      regular_elies += elies.select do |ely|
        ely["filters"] = [] if ely["filters"] == nil
        current_filter_array = ely["filters"].map do |ely_filter|
          active.filters.find{|active_filter| active_filter["id"] == ely_filter["id"]}["slug"]
        end
        intersection_array = current_filter_array & filters_array
        !intersection_array.empty?
      end
    end

    # Level3 filter    
    if has_level3_filters
      level3_filters_array = level3_filters.split(",")
      level3_elies += elies.select do |ely|
        ely["level3_filters"] = [] if ely["level3_filters"] == nil
        current_filter_array = ely["level3_filters"].map do |ely_filter|
          active.level3_filters.find{|active_filter| active_filter["id"] == ely_filter["id"]}["slug"]
        end
        intersection_array = current_filter_array & level3_filters_array
        !intersection_array.empty?
      end
    end

    selected_elies = []
    if has_regular_filters && has_level3_filters
      intersection_of_filters = level3_elies.map { |e| e["id"]  } & regular_elies.map{ |e| e["id"]  }
      selected_elies = elies.select { |e| intersection_of_filters.include?(e["id"])  }      
    elsif has_regular_filters
      selected_elies = regular_elies
    elsif has_level3_filters
      selected_elies = level3_elies
    else
      selected_elies = elies
    end
      

    selected_elies
  end

end
