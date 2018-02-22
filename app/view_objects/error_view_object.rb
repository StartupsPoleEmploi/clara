class ErrorViewObject < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @errors = array_for(locals[:errors])
  end

  def has_error
    !(@errors.blank?)
  end

  def main_error
    @errors.first
  end

end
