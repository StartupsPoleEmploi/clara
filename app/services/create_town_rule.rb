class CreateTownRule

  def call(citycode, uuid)
    activated = ActivatedModelsService.instance
    Rule.new(
      name: "r_#{uuid}_citycode_#{citycode}_id_#{rand().to_s[2..-1]}",
      kind: "simple",
      variable_id: activated.variables.detect{ |v| v["name"] ==  "v_location_citycode" }.try(:[], "id"),
      operator_kind: "equal",
      value_eligible: citycode
    )
  end

end
