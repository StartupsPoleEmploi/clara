
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

  def api_eligible(asker, filters)
    calculator = AidCalculationService.get_instance(asker)
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

  def _filter(elies, filters)
    _find_elies("filters", filters, elies)
  end

end
