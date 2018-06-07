class ResultDefault < ViewObject

  def after_init(args)
    @all_data = hash_for(args).with_indifferent_access
  end

  def sort_and_order(prop)
    # .sort_by{|e| e['ordre_affichage']}
    grouped = @all_data[prop].group_by{|e| e['contract_type_id']}.transform_values{|v| v.sort_by{|e| e['ordre_affichage']}}
    grouped
  end

end

