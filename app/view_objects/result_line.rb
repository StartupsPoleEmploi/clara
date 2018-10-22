
class ResultLine < ViewObject

  def after_init(args)
    locals =         hash_for(args)
    @line =          hash_for(locals[:line])
    @aids =          array_of_hash_for(@line[:aids])
    @contract_type = hash_for(locals[:contract_type])
    @clazz =         string_for(locals[:clazz])
  end

  def has_line
    !@line.blank?
  end

  def line_id
    "#{@clazz}__#{_safe_biz_id}"
  end
  
  def clazz
    suffix = "green"  if @clazz == "eligible"
    suffix = "orange" if @clazz == "uncertain"
    suffix = "red"    if @clazz == "ineligible"
    "c-result-line--#{suffix} #{_safe_biz_id}"
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
    "#{@line[:contract_type_business_id]}".parameterize
  end

end
