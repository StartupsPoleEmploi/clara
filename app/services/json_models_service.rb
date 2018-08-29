class JsonModelsService


  def self.rules
    r_all = JSON.parse(Rule.all.to_json(:only => [ :id, :name, :value_eligible, :operator_type, :composition_type, :variable_id, :value_ineligible ], :include => {slave_rules: {only:[:id, :name]}}))
    all_rules = r_all.map{|h| HashService.new.recursive_compact(h)}
    all_rules
  end

  def self.aids
    JSON.parse(Aid.activated.to_json(:only => [ :id, :name, :slug, :short_description, :rule_id, :contract_type_id ], :include => {filters: {only:[:id, :slug]}}))
  end

  def self.filters
    JSON.parse(Filter.all.to_json(:only => [ :id, :slug ]))
  end

  def self.variables
    JSON.parse(Variable.all.to_json(:only => [ :id, :name, :variable_type, :description ]))
  end

end
