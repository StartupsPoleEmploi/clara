  class RoutesList
    
    def self.questions
      all_pathes.select {|key| key.to_s.include?('_question')}      
    end    

    def self.get_questions
      questions.select {|key| key.to_s.start_with?('new_')}      
    end  

    def self.not_questions
      all_pathes.reject {|key| key.to_s.include?('_question')}      
    end    

    def self.all_routes
      Hash[Rails.application.routes.routes.map { |r| [r.name, r.path.spec.to_s] }]
    end    

    def self.all_pathes
      all_routes.transform_keys{ |key| key.to_s + '_path' }
    end    

    def self.all_simplified_pathes
      all_routes.transform_keys{ |key| key.to_s + '_path' }.transform_values{ |value| value[0..-11]}
    end    

    def self.get_path_for_relative_url(relative_url)
      selection = all_simplified_pathes.select do |key,value| 
        recognize(value)[:controller] == recognize(relative_url)[:controller] && 
          recognize(value)[:action] == recognize(relative_url)[:action] 
      end
      selection[0]
    end    

    def self.recognize(str)
      Rails.application.routes.recognize_path(str)
    end

  end
