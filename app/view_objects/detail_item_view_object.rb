class DetailItemViewObject < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @html_content = locals[:html_content]
  end

  def empty_content?
    n = Nokogiri::HTML(@html_content)
    nbsp = Nokogiri::HTML("&nbsp;").text
    n.css('*').each do |node|
      txt_without_nbsp =  node.inner_text.gsub(nbsp, "")
      not_displayed = node[:style].to_s.include?("display: none;")
      node.remove if txt_without_nbsp == ''
      node.remove if not_displayed
    end
    n.inner_text.gsub(/\W/,'').blank?
  end


  def actual_content
    @html_content.to_s.html_safe
  end

end
