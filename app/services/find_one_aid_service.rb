class FindOneAidService

  def from_slug(slug)
    res = {}
    found = Aid.find_by(slug: slug)
    if found
      res = found.attributes
      res.delete "id"
      res.delete "rule_id"
      res.delete "contract_type_id"
    end
    res
  end
  
end
