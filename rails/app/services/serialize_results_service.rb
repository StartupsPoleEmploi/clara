
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
     flat_all_filter: JSON.parse(Rails.cache.fetch("filters") {Filter.all.to_json(:only => [ :id, :slug, :name, :ordre_affichage, :description ])}),
     asker: asker.attributes
    }
    res
  end

  def api_eligible(asker, filters, need_filters, custom_filters, custom_parent_filters)
    calculator = AidCalculationService.get_instance(asker)
    _whitelist(_filter(calculator.every_eligible, filters, need_filters, custom_filters, custom_parent_filters))
  end

  def api_ineligible(asker, filters, need_filters, custom_filters, custom_parent_filters)
    calculator = AidCalculationService.get_instance(asker)
    _whitelist(_filter(calculator.every_ineligible, filters, need_filters, custom_filters, custom_parent_filters))
  end

  def api_uncertain(asker, filters, need_filters, custom_filters, custom_parent_filters)
    calculator = AidCalculationService.get_instance(asker)
    _whitelist(_filter(calculator.every_uncertain, filters, need_filters, custom_filters, custom_parent_filters))
  end

  def _whitelist(aids)
    aids.map {|aid| WhitelistAidService.new.for_aid_in_list(aid)}
  end

  def _extract_custom_childrens(custom_parent_slug_list)
    res = ""

    return res if !(custom_parent_slug_list.is_a?(String) && !custom_parent_slug_list.empty?) 

    active = ActivatedModelsService.instance
    
    parent_slugs = custom_parent_slug_list.split(",")
    parent_ids = parent_slugs.map { |parent_slug|  active.custom_parent_filters.find { |c| c["slug"] == parent_slug }["id"] }
    selection = active.custom_filters.select { |custom_filter|  parent_ids.include?(custom_filter["custom_parent_filter_id"]) }
    if selection.is_a?(Array) && !selection.empty?
      res = selection.map { |e| e["slug"]  }.join(",")
    end
    res
  end

  def _find_elies(property, initial_filters, all_elies)
    resulting_elies = []
    if (initial_filters.is_a?(String) && !initial_filters.empty?)
      active = ActivatedModelsService.instance
      filters_array = initial_filters.split(",")
      resulting_elies += all_elies.select do |ely|
        ely[property] = [] if ely[property] == nil
        current_filter_array = ely[property].map do |ely_filter|
          a=active.public_send(property)
          b=a.find do |active_filter| 
            active_filter["id"] == ely_filter["id"]
          end
          b["slug"]
        end
        intersection_array = current_filter_array & filters_array
        !intersection_array.empty?
      end
    end
    resulting_elies    
  end

  def _filter(elies, filters, need_filters, custom_filters, custom_parent_filters)
    regular_elies              = _find_elies("filters", filters, elies)
    need_elies                 = _find_elies("need_filters", need_filters, elies)
    custom_filters_from_parent = _extract_custom_childrens(custom_parent_filters)
    custom_filters_called      = custom_filters.to_s + custom_filters_from_parent.to_s
    custom_elies               = _find_elies("custom_filters", custom_filters_called, elies)

    selected_elies = []

    all_hash = {
      regular: {elies: regular_elies, filters: filters},
      need: {elies: need_elies, filters: need_filters},
      custom: {elies: custom_elies, filters: custom_filters_called},
    }

    is_filter_required = proc { |k,v| v.is_a?(Hash) && v[:filters].is_a?(String) && !v[:filters].empty? }

    number_of_filter_required = all_hash.count(&is_filter_required)

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
        all_hash
          .map { |k,v| v[:elies]  }
          .delete_if{|e| e.size == 0}
          .map { |e| e.map { |e| e["id"] } }
          .inject(:&)
      selected_elies = elies.select { |e| intersection_of_filters.include?(e["id"])  } 
    end        

    selected_elies
  end

end
