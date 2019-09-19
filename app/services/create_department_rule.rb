class CreateDepartmentRule

  def call(department, uuid, operator_kind)
    dep_nb = department.keys[0]
    dep_name = department.values[0]
    prefix = operator_kind.include?("not") ? "Ne pas résider" : "Résider"
    activated = ActivatedModelsService.instance
    Rule.new(
      name: "r_#{uuid}_department_#{operator_kind}_#{dep_nb}_id_#{rand().to_s[2..-1]}",
      kind: "simple",
      variable_id: activated.variables.detect{ |v| v["name"] ==  "v_location_citycode" }.try(:[], "id"),
      operator_kind: operator_kind,
      description: "#{prefix} dans le département #{dep_name}",
      value_eligible: dep_nb
    )
  end

end
