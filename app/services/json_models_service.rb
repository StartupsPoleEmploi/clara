class JsonModelsService

  def self.tracings
    res = []
    begin
      res = JSON.parse(Tracing.all.to_json(:only => [ :id, :rule_id, :all_aids ], :include => {aids: {only:[:slug]}}))
    rescue => e
      res = []
    end
    res
  end

  def self.rules
    r_all = JSON.parse(Rule.all.to_json(:only => [ :id, :name, :value_eligible, :operator_kind, :composition_type, :variable_id, :value_ineligible ], :include => {slave_rules: {only:[:id, :name]}}))
    all_rules = r_all.map{|h| HashService.new.recursive_compact(h)}
    all_rules
  end

  def self.aids
    JSON.parse(Aid.activated.to_json(:only => [ :id, :name, :slug, :short_description, :rule_id, :contract_type_id, :ordre_affichage ], :include => {filters: {only:[:id, :slug]}, custom_filters: {only:[:id, :slug, :custom_parent_filter_id]}, need_filters: {only:[:id, :slug]}}))
  end

  def self.filters
    JSON.parse(Filter.all.to_json(:only => [ :id, :slug, :ordre_affichage ]))
  end

  def self.need_filters
    JSON.parse(NeedFilter.all.to_json(:only => [ :id, :slug ]))
  end

  def self.custom_filters
    JSON.parse(CustomFilter.all.to_json(:only => [ :id, :slug, :custom_parent_filter_id ]))
  end

  def self.custom_parent_filters
    JSON.parse(CustomParentFilter.all.to_json(:only => [ :id, :slug ]))
  end

  def self.contracts
    JSON.parse(ContractType.all.to_json(:only => [ :id, :slug, :name  ]))
  end

  def self.variables
    JSON.parse(Variable.all.to_json(:only => [ :id, :name, :name_translation, :elements_translation, :variable_kind, :description, :elements ]))
  end

end
