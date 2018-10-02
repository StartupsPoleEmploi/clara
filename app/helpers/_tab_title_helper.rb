module TabTitleHelper
  class TitleCalculator  

    def initialize(the_request_object)
      @request_service = RequestPathService.get_instance(the_request_object)
    end

    def calculate_title(title_data)
      if !title_data.blank?
        if @request_service.root_path?
          return title_data
        elsif @request_service.type_path?
          return "Découvrez les aides de type #{title_data}" + default_title
        elsif @request_service.detail_path?
          return "Présentation de l'aide #{title_data}" + default_title
        elsif @request_service.aides_path?
          return title_data + default_title
        elsif @request_service.question_path?
          return title_data + default_title
        else
          return title_data + default_title
        end
      end
      smallest_title
    end

    def calculate_description(description_data)
      res = ""
      if @request_service.root_path?
        res = "Découvrez les aides et mesures qui vont accélérer votre reprise d'emploi"
      elsif @request_service.question_path?
        res = description_data
      end
      # p '- - - - - - - - - - - - - - res- - - - - - - - - - - - - - - -' 
      # pp res
      # p ''
      res
    end

    def default_title
      " | " + smallest_title
    end

    def smallest_title
      "Clara – un service Pôle emploi"
    end

  end
end
