class TypeExplanation < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @number_of_aids = integer_for(locals[:number_of_aids])
    @slug = string_for(locals[:slug])
  end

  def has_text
    false
    # return full_text != "" && @number_of_aids > 0
  end

  def number_of_aids
    @number_of_aids
  end


end
