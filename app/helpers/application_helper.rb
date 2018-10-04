module ApplicationHelper

  def title_data(text)
    content_for :title_data, text.to_s
  end

  def description_data(text)
    # quick hack to shorten the description
    local_text = text.to_s
    if request && request.respond_to?("path") && request.path.include?("/aides/detail")
      plain_text = Nokogiri::HTML(CGI::unescapeHTML(text)).text.to_s
      escaped_text = plain_text.split("(")[0].to_s.split(".")[0].to_s.split(":")[0].to_s
      if escaped_text.size > 155
        escaped_text = escaped_text.split(",")[0].to_s
      end
      local_text = escaped_text
    end
    content_for :description_data, local_text
  end

  def view_object(name, args = {})
    class_name = name.to_s.titleize.split(" ").join("")
    class_name.constantize.new(self, args)
  end
    
end
