class ResultAid < ViewObject

  def after_init(args)
    locals     = hash_for(args)
    @aid       = hash_for(locals[:aid])
    @the_index = integer_for(locals[:the_index])
    @for_id    = string_for(locals[:for_id])

  end

  def css_addendum(the_index)
    a = the_index == 0 ? "first" : ""
    "#{a} #{@aid[:slug]}"
  end

  def name
    @aid[:name]
  end

  def short_description
    @aid[:short_description]
  end

  def link_to_detailed_aid
    slug = @aid[:slug]
    @for_id.blank? ? "#{detail_path(slug)}" : "#{detail_path(slug)}?for_id=#{@for_id}"
  end

end
