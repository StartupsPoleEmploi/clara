
class ResultLine < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @aids =  array_of_hash_for(locals[:aids])
    @contract = hash_for(locals[:contract])
    @hide_title = boolean_for(locals[:hide_title])
  end
  
  def clazz
    suffix = "green"  if @clazz == "eligible"
    suffix = "orange" if @clazz == "uncertain"
    suffix = "red"    if @clazz == "ineligible"
    "c-result-line--#{suffix} #{_safe_biz_id}"
  end

  def hide_title?
    @hide_title
  end

  def ordered_aids
    @aids.sort_by { |aid| aid[:ordre_affichage] }
  end

  def _safe_biz_id
    res = "#{@contract[:business_id]}".parameterize
    res
  end

end
