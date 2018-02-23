class Breadcrumb < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @where = string_for(locals[:where])
    @context = locals[:context] if locals[:context]
  end

  def display_form?
    @where == "question"
  end

  def display_result?
    p '- - - - - - - - - - - - - - @context- - - - - - - - - - - - - - - -' 
    p @context.request.path.inspect
    p ''
    @context.request.path == aides_path && @context.params[:for_id]
  end

  def display_detail?
  end

end
