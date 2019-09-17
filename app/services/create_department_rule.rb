class CreateDepartmentRule

  def call(dep_nb, uuid)
    activated = ActivatedModelsService.instance
    Rule.new(
      name: "r_#{uuid}_department_#{dep_nb}_id_#{rand().to_s[2..-1]}",
      kind: "simple",
      variable_id: activated.variables.detect{ |v| v["name"] ==  "v_location_citycode" }.try(:[], "id"),
      operator_kind: "starts_with",
      value_eligible: dep_nb
    )
  end

end
