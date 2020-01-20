class RoutesList
  
  def self.questions
    all_pathes.select {|key| key.to_s.include?('_question')}      
  end    

  def self.admin
    all_pathes.select {|key| key.to_s.start_with?('admin_')}      
  end    

  def self.asked_questions
    questions.select {|key| key.to_s.start_with?('new_')}      
  end  

  def self.not_questions
    all_pathes.reject {|key| key.to_s.include?('_question')}      
  end    

  def self.all_routes
    Hash[Rails.application.routes.routes.map { |r| [r.name, r.path.spec.to_s] }].transform_values{ |e| e.gsub("(.:format)", "")}
  end    

  def self.all_routes_with_verb
    Rails.application.routes.routes.map { |r| {name: r.name, url: r.path.spec.to_s.gsub("(.:format)", ""), verb: r.verb  }}
  end    

  def self.all_admin_routes_with_verb
    all_routes_with_verb.select{ |r| r[:url].start_with?("/admin") }
  end    

  def self.all_pathes
    all_routes.transform_keys{ |key| key.to_s + '_path' }
  end    

end
