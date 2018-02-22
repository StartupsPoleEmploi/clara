class SitemapIndex < ViewObject

  def after_init(args)
    @locals=hash_for(args)
  end

  def generated_aides_sitemap_url
    res = Hash.new
    res[:protocol] = @locals[:request].ssl? ? 'https' : 'http'
    res[:host] = @locals[:request].host
    aides_sitemap_url(res)
  end

  def generated_types_sitemap_url
    res = Hash.new
    res[:protocol] = @locals[:request].ssl? ? 'https' : 'http'
    res[:host] = @locals[:request].host
    types_sitemap_url(res)
  end

  def generated_detail_url(slug)
    res = Hash.new
    res[:protocol] = @locals[:request].ssl? ? 'https' : 'http'
    res[:host] = @locals[:request].host
    detail_url(slug, res)
  end

  def generated_type_url(slug)
    res = Hash.new
    res[:protocol] = @locals[:request].ssl? ? 'https' : 'http'
    res[:host] = @locals[:request].host
    type_url(slug, res)
  end

end
