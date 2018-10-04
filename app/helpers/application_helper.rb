module ApplicationHelper

  def title_data(text)
    content_for :title_data, text.to_s
  end

  def description_data(text)
    # quick hack to shorten the description
    local_text = text.to_s.split("(")[0].to_s.split(".")[0].to_s.split(":")[0].to_s
    content_for :description_data, local_text
  end

  def view_object(name, args = {})
    class_name = name.to_s.titleize.split(" ").join("")
    class_name.constantize.new(self, args)
  end
    
end
