module ApplicationHelper

  def cookie_preference_already_defined?
    session[:cookie] != nil
  end

  def title_data(text)
    content_for :title_data, text.to_s
  end

  def from_pe?(the_request)
    urls = ENV['ARA_URL_PE'] || "nothing"
    urls.split(",").include?(the_request.remote_ip)
  end

  def ga_disabled?
    session[:cookie] && session[:cookie]["forbid_statistic"] && session[:cookie]["forbid_statistic"] == "1"
  end

  def hj_disabled?
    session[:cookie] && session[:cookie]["forbid_navigation"] && session[:cookie]["forbid_navigation"] == "1"
  end

  def empty_image
    "data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs="
  end

  def search_hash(address, classes_of_input)
    {"placeholder" => "Exemple : 44220", "aria-autocomplete" => "both", "aria-describedby" => "a11yAutocomplete", "aria-expanded" => "false", "aria-owns" => "results", autocomplete: "off", "class" => classes_of_input, name: "address_form[label]", value: "#{address.label}", title: "Mon code postal"}.delete_if { |k, v| v.empty? }
  end

  def description_data(text)
    local_text = text.to_s
    if request && request.respond_to?("path") && request.path.include?("/aides/detail")
      plain_text = Nokogiri::HTML(CGI::unescapeHTML(text)).text.to_s
      # quick hack to shorten the description
      escaped_text = plain_text.split("(")[0].to_s.split(".")[0].to_s.split(":")[0].to_s
      if escaped_text.size > 155
        escaped_text = escaped_text.split(",")[0].to_s
      end
      local_text = escaped_text.html_safe
    end
    content_for :description_data, local_text
  end

  def view_object(name, args = {})
    class_name = name.to_s.titleize.split(" ").join("")
    class_name.constantize.new(self, args)
  end
    
end
