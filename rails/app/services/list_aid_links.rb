class ListAidLinks

  def call

    Aid.all.map do |aid|
      links = []
      links.concat(URI.extract(aid.what))
      links.concat(URI.extract(aid.how_much))
      links.concat(URI.extract(aid.additionnal_conditions))
      links.concat(URI.extract(aid.how_and_when))
      links.concat(URI.extract(aid.limitations))
      {
        aid_slug: aid.slug,
        links: links.filter{|e| e.start_with?('http')}
      }
    end


  end
  
end
