class SitemapAides < SitemapIndex

  attr_reader :all_aides

  def after_init(args)
    @locals=hash_for(args)
    @all_aides = array_for(@locals[:aides])
  end

end
