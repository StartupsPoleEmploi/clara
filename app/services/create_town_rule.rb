class CreateTownRule

  def call(town, uuid, operator_kind)
    citycode = town.keys[0]
    cityname = town.values[0]
    prefix = operator_kind.include?("not") ? "Ne pas résider" : "Résider"  
    activated = ActivatedModelsService.instance
    Rule.new(
      name: "r_#{uuid}_citycode_#{operator_kind}_#{citycode}_id_#{rand().to_s[2..-1]}",
      kind: "simple",
      variable_id: activated.variables.detect{ |v| v["name"] ==  "v_location_citycode" }.try(:[], "id"),
      operator_kind: operator_kind,
      description: "#{prefix} à #{cityname}"
      value_eligible: citycode
    )
  end

end
