class DetectBrokenLinks

  def call
    Broken.destroy_all
    broken_links = ListBrokenLinks.new.call
    broken_links.each do |broken_link|  
      Broken.new(
        url: broken_link[:url],
        code: broken_link[:code],
        new_url: broken_link[:new_url],
        aids_slug: broken_link[:aids_slug].to_json
      ).save!
    end
  end
  
end
