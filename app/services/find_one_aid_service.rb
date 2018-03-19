class FindOneAidService

  def from_slug(slug)
    Aid.find_by(slug: slug)
  end
  
end
