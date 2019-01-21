class RuleValidator < ActiveModel::Validator
  def validate(record)
    p '- - - - - - - - - - - - - - attributes- - - - - - - - - - - - - - - -' 
    pp record.attributes
    p ''
    if record.kind != "simple" && record.kind != "composite"
      record.errors.add(:kind, :invalid)
    elsif record.kind == "simple"
      _validate_simple_rule(record)
    elsif record.kind == "composite"
      _validate_composite_rule(record)
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
                              "operator_type",
                              "value_eligible",
                            ]
    attributes_mandatory.each do |mandatory_attr|
      if attr_h[mandatory_attr].blank?
        record.errors.add(mandatory_attr, :blank)
      end
    end
  end

  def _validate_simple_rule_authorized_fields(record)
    attr_h = record.attributes
    attributes_whitelist = ["name", 
                              "kind", 
                              "description", 
                              "variable_id", 
                              "operator_type", 
                              "value_eligible",
                              "id", 
                              "created_at", 
                              "updated_at", 
                            ]

    other_attributes = attr_h.except(*attributes_whitelist)
    p '- - - - - - - - - - - - - - other_attributes- - - - - - - - - - - - - - - -' 
    pp other_attributes
    p ''
    unless other_attributes.values.all? { |v| v.blank?  }
      record.errors.add(:kind, :confirmation)
    end
  end

  def _validate_composite_rule(attr_h)
    
  end

end
