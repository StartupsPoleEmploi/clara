class ResultDefault < ViewObject

  def after_init(args)
    @eligibles = args[:flat_all_eligible]
    @ineligibles = args[:flat_all_ineligible]
    @uncertains = args[:flat_all_uncertain]
    @contract_types = args[:flat_all_contract]
    @filters = args[:flat_all_filter]
  end

  def sort_and_order_eligies
    # .sort_by{|e| e['ordre_affichage']}
    grouped = @eligibles.group_by{|e| e['contract_type_id']}
    grouped
  end

end

