class TypeShow < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @contract_type = hash_for(locals[:contract_type])
    @aids = array_for(locals[:aids])
  end

  def contract_type
    @contract_type
  end

  def title
    @contract_type[:description]
  end

  def clazz
    "c-detail-title--#{@contract_type[:business_id]}"
  end

  def has_line
    @aids.size > 0
  end

  def line
    FilterRawAidsService.new(@aids).go[0]
  end

  def title_of_tab
    "#{@contract_type[:name]}"
  end

end
