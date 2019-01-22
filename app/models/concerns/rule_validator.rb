class RuleValidator < ActiveModel::Validator
  def validate(record)
    p '- - - - - - - - - - - - - - record0- - - - - - - - - - - - - - - -' 
    pp record.errors
    p ''
    if record.kind != "simple" && record.kind != "composite"
      p '- - - - - - - - - - - - - - record1- - - - - - - - - - - - - - - -' 
      pp record.errors
      p ''
      record.errors.add(:kind, :invalid)
    elsif record.kind == "simple"
      _validate_simple_rule(record)
    elsif record.kind == "composite"
      _validate_composite_rule(record)
    end
  end

  def _validate_composite_rule(record)
    _validate_composite_rule_authorized_fields(record)
    _validate_composite_rule_mandatory_fields(record)    
    _validate_composite_rule_numerality_of_fields(record)
  end

  def _validate_composite_rule_authorized_fields(record)
    attr_h = JSON.parse(record.to_json(:include => {slave_rules: {only:[:id, :name]}}))
    attributes_whitelist = ["name", 
                              "kind", 
                              "description", 
                              "slave_rules", 
                              "composition_type", 
                              "id", 
                              "created_at", 
                              "updated_at", 
                            ]

    other_attributes = attr_h.except(*attributes_whitelist)
    other_attributes.each do |k,v|  
      if v.present?
        record.errors.add(k, :present)
      end
    end
  end

  def _validate_composite_rule_mandatory_fields(record)
    attr_h = JSON.parse(record.to_json(:include => {slave_rules: {only:[:id, :name]}}))
    attributes_mandatory = ["name",
                              "kind",
                              "slave_rules",
                              "composition_type",
                            ]
    attributes_mandatory.each do |mandatory_attr|
      if attr_h[mandatory_attr].blank?
        record.errors.add(mandatory_attr, :blank)
      end
    end
  end

  def _validate_composite_rule_numerality_of_fields(record)
    attr_h = JSON.parse(record.to_json(:include => {slave_rules: {only:[:id, :name]}}))
    if attr_h["slave_rules"] && attr_h["slave_rules"].size < 2
      record.errors.add("slave_rules", :slave_rules_number, count: 2)
    end
  end

  def _validate_simple_rule(record)
    _validate_simple_rule_authorized_fields(record)
    _validate_simple_rule_mandatory_fields(record)
  end

  def _validate_simple_rule_mandatory_fields(record)
    attr_h = record.attributes
    attributes_mandatory = ["name",
                              "kind",
                              "variable_id",
                              "operator_kind",
                              "value_eligible",
                            ]
    attributes_mandatory.each do |mandatory_attr|
      if attr_h[mandatory_attr].blank?
        record.errors.add(mandatory_attr, :blank)
      end
    end
  end

  def _validate_simple_rule_authorized_fields(record)
    attr_h = JSON.parse(record.to_json(:include => {slave_rules: {only:[:id, :name]}}))
    attributes_whitelist = ["name", 
                              "kind", 
                              "description", 
                              "variable_id", 
                              "operator_kind", 
                              "value_eligible",
                              "id", 
                              "created_at", 
                              "updated_at", 
                            ]

    other_attributes = attr_h.except(*attributes_whitelist)
    other_attributes.each do |k,v|  
      if v.present?
        record.errors.add(k, :present)
      end
    end
  end



end
