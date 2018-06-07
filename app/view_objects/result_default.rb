class ResultDefault < ViewObject

  def after_init(args)
    @all_data = hash_for(args).with_indifferent_access
  end

  def sort_and_order(prop)
    # .sort_by{|e| e['ordre_affichage']}
    contract_types = @all_data["flat_all_contract"]
    h = @all_data[prop] || {}
    grouped = h.group_by{|e| e['contract_type_id']}.transform_values{|v| v.sort_by{|e| e['ordre_affichage']}}
    v = grouped.values
    v.sort_by{ |e| contract_types.detect{|c| c["id"] == e[0]['contract_type_id']}["ordre_affichage"]}
  end

end

