class CreateRegionRule

  def call(region_name, uuid)
    activated = ActivatedModelsService.instance
    Rule.new(
      name: "r_#{uuid}_region_#{region_name.parameterize}_id_#{rand().to_s[2..-1]}",
      kind: "simple",
      variable_id: activated.variables.detect{ |v| v["name"] ==  "v_location_state" }.try(:[], "id"),
      operator_kind: "starts_with",
      value_eligible: region_name[0..5]
    )
  end

end
