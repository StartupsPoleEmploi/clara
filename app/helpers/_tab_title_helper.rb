module TabTitleHelper
  class TitleCalculator  

    def initialize(the_request_object)
      @current_path = GetCurrentPathService.call(a_request: the_request_object)
    end

    def calculate_title(raw_title_data)
      title_data =  ""
      title_data =  CGI.unescapeHTML(raw_title_data) if raw_title_data.is_a?(String)
      if !title_data.blank?
        if @current_path == "root_path"
          return title_data
        elsif @current_path == "type_path"
          return "Découvrez les aides de type #{title_data}" + default_title
        elsif @current_path == "detail_path"
          return "Aide | " + title_data + default_title
        elsif @current_path == "aides_path"
          return title_data + default_title
        else
          return title_data + default_title
        end
      end
      smallest_title
    end

    def calculate_description(description_data)
      res = ""
      if @current_path == "root_path"
        res = "Découvrez les aides et mesures qui vont accélérer votre reprise d'emploi"
      else
        res = description_data
      end
      res
    end

    def result_page?
      @current_path == "aides_path"
    end

    def default_title
      " | " + smallest_title
    end

    def smallest_title
      "Clara – un service Pôle emploi"
    end

  end
end
