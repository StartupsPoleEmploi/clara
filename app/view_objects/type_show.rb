class TypeShow < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @contract = hash_for(locals[:contract])
    @aids = array_for(locals[:aids])
  end

  def contract_type
    @contract
  end

  def title
    @contract[:description]
  end

  def clazz
    "c-detail-title--#{@contract[:business_id]}"
  end

  def has_line
    @aids.size > 0
  end

  def line
    FilterRawAidsService.new(@aids).go[0]
  end

  def title_of_tab
    "#{@contract[:name]}"
  end

end
