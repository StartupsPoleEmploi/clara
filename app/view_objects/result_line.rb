
class ResultLine < ViewObject

  def after_init(args)
    locals =         hash_for(args)
    @line =          hash_for(locals[:line])
    @aids =          array_of_hash_for(locals[:aids])
    @contracts = array_of_hash_for(locals[:contracts])
    @show_expander = boolean_for(locals[:show_expander])
  end

  def has_line
    !@line.blank?
  end

  def line_id
    "#{_safe_biz_id}"
  end
  
  def clazz
    suffix = "green"  if @clazz == "eligible"
    suffix = "orange" if @clazz == "uncertain"
    suffix = "red"    if @clazz == "ineligible"
    "c-result-line--#{suffix} #{_safe_biz_id}"
  end

  def show_expander
    @show_expander
  end

  def ordered_aids
    @aids.sort_by { |aid| aid[:ordre_affichage] }
  end

  def aids_size
    @aids.size
  end

  def business_id
    @contract_type[:business_id]
  end

  def _safe_biz_id
    "#{@contract_type[:business_id]}"
  end

end
