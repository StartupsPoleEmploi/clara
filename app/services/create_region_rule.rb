class CreateRegionRule

  def call(region, uuid, operator_kind)
    region_trigram = region.keys[0]
    region_txt = region.values[0]
    activated = ActivatedModelsService.instance
    prefix = operator_kind.include?("not") ? "Ne pas résider" : "Résider"

    Rule.new(
      name: "r_#{uuid}_region_#{operator_kind}_#{region_name.parameterize}_id_#{rand().to_s[2..-1]}",
      kind: "simple",
      variable_id: activated.variables.detect{ |v| v["name"] ==  "v_location_state" }.try(:[], "id"),
      operator_kind: operator_kind,
      value_eligible: region_name[0..5],
      description: "#{prefix} dans la région #{region_txt}"
    )
  end

end
