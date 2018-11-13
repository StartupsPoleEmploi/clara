
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

  def _find_elies(property, initial_filters, all_elies)
    resulting_elies = []
    if (initial_filters.is_a?(String) && !initial_filters.empty?)
      active = ActivatedModelsService.instance
      filters_array = initial_filters.split(",")
      resulting_elies += all_elies.select do |ely|
        ely[property] = [] if ely[property] == nil
        current_filter_array = ely[property].map do |ely_filter|
          active.public_send(property).find{|active_filter| active_filter["id"] == ely_filter["id"]}["slug"]
        end
        intersection_array = current_filter_array & filters_array
        !intersection_array.empty?
      end
    end
    resulting_elies    
  end

  def _filter(elies, filters, level3_filters, custom_filters, custom_parent_filters)
    has_regular_filters = filters.is_a?(String) && !filters.empty?
    has_level3_filters = level3_filters.is_a?(String) && !level3_filters.empty?
    # active = ActivatedModelsService.instance

    regular_elies       = _find_elies("filters", filters, elies)
    # p '- - - - - - - - - - - - - - regular_elies- - - - - - - - - - - - - - - -' 
    # pp regular_elies
    # p ''
    level3_elies        = _find_elies("level3_filters", level3_filters, elies)
    # p '- - - - - - - - - - - - - - level3_elies- - - - - - - - - - - - - - - -' 
    # pp level3_elies
    # p ''
    custom_elies        = _find_elies("custom_filters", custom_filters, elies)
    custom_parent_elies = []

    selected_elies = []

    all_hash = {
      regular: {elies:regular_elies, filters:filters},
      level3: {elies:level3_elies, filters:level3_filters},
      custom: {elies:custom_elies, filters:custom_filters},
      parent: {elies:custom_parent_elies, filters:custom_parent_filters},
    }
    filtered_elies = [regular_elies, level3_elies, custom_elies, custom_parent_elies]
    all_filters = [filters, level3_filters, custom_filters, custom_parent_filters]

    is_filter_required = proc { |k,v| v.is_a?(Hash) && v[:filters].is_a?(String) && !v[:filters].empty? }

    number_of_filter_required = all_hash.count(&is_filter_required)
    # p '- - - - - - - - - - - - - - all_hash- - - - - - - - - - - - - - - -' 
    # pp all_hash
    # p ''
    # p '- - - - - - - - - - - - - - number_of_filter_required- - - - - - - - - - - - - - - -' 
    # pp number_of_filter_required
    # p ''

    if number_of_filter_required == 0
      # if no filter is required by user, just don't filter, send the elies back
      selected_elies = elies
    elsif number_of_filter_required == 1
      # if only one filter is required by user, just send back the filtered items
      # [0] is the key, [1] the value
      selected_elies = all_hash.find(&is_filter_required)[1][:elies]
    else
      # if multiple filters are required by user, send back intersection of filtering
      intersection_of_filters = 
        all_hash.map { |e| e[:elies]  }.delete_if{|e| e.size == 0}.inject(:&)
      selected_elies = elies.select { |e| intersection_of_filters.include?(e["id"])  } 
    end        

    selected_elies
  end

end
