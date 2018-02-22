class DetailItemRemark < ViewObject

  def after_init(args)
    locals   = hash_for(args)
    @content = string_for(locals[:content])
  end

  def content
    stripped = strip_tags(@content).gsub(/[\\r\\n]+/m, "").squish
    has_content = !!/[a-z]/.match(stripped)
    if has_content
      return @content.html_safe
    else
      return nil
    end
  end

end
