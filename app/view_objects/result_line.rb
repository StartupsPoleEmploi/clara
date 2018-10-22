
class ResultLine < ViewObject

  def after_init(args)
    locals = hash_for(args)
    p '- - - - - - - - - - - - - - locals- - - - - - - - - - - - - - - -' 
    pp locals
    p ''
    @aids =  array_of_hash_for(locals[:aids])
    p '- - - - - - - - - - - - - - @aids- - - - - - - - - - - - - - - -' 
    pp @aids
    p ''
    @contract = hash_for(locals[:contract])
    p '- - - - - - - - - - - - - - @contract- - - - - - - - - - - - - - - -' 
    pp @contract
    p ''
    # @clazz =         string_for(locals[:clazz])
  end

  def has_line
    # !@line.blank?
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
    # @aids.size
  end

  def business_id
    # @contract_type[:business_id]
  end

  def _safe_biz_id
    "#{@contract['business_id']}".parameterize
  end

end
