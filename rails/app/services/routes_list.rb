class RoutesList
  
  def questions
    all_pathes.select {|key| key.to_s.include?('_question')}      
  end    

  def asked_questions
    questions.select {|key| key.to_s.start_with?('new_')}      
  end  

  def all_pathes
    all_routes.transform_keys{ |key| key.to_s + '_path' }
  end 
     
  def all_routes
    Hash[Rails.application.routes.routes.map { |r| [r.name, r.path.spec.to_s] }].transform_values{ |e| e.gsub("(.:format)", "")}
  end  
end
