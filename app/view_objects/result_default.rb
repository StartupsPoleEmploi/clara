class ResultDefault < ViewObject

  def after_init(args)
    @all_data = hash_for(args).with_indifferent_access
  end

  def sort_and_order(prop)
    contract_types = @all_data["flat_all_contract"]
    h = @all_data[prop] || {}

    h
      .group_by{|e| e['contract_type_id']}
      .transform_values{|v| v.sort_by{|e| e['ordre_affichage']}}
      .values
      .sort_by{ |e| contract_types.detect{|c| c["id"] == e.sample['contract_type_id']}["ordre_affichage"]}
  end

  def title_for(aids_per_contract)
    contract_types = @all_data["flat_all_contract"]
    str_title = contract_types.detect{|e| e["id"] == aids_per_contract[0]["contract_type_id"]}["name"]
    str_nb = aids_per_contract.size
    "#{str_nb} #{str_title}"
  end

end

