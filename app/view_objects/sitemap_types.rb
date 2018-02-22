class SitemapTypes < SitemapIndex

  attr_reader :all_types

  def after_init(args)
    @locals=hash_for(args)
    @all_types = array_for(@locals[:types])
  end

end
