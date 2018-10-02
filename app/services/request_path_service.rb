class RequestPathService

  class << self
    protected :new
  end

  @@the_double = nil

  def RequestPathService.set_instance(the_double)
    @@the_double = the_double
  end

  def RequestPathService.dont_stub
    set_instance(nil)
  end

  def RequestPathService.get_instance(request)
    @@the_double.nil? ? RequestPathService.new(request) : @@the_double
  end
  
  def initialize(request)
    @request = request
  end

  def own_path
    @request.path
  end

  def question_path?
    own_path_simplified = own_path.gsub("(.:format)", "")
    RoutesList.questions.values.map { |e| e.gsub("(.:format)", "") }.include?(own_path_simplified)
  end

  def root_path?
    RoutesList.all_pathes["root_path"] == own_path
  end

  def type_path?
    RoutesList.all_pathes["type_path"] == own_path
  end

  def detail_path?
    RoutesList.all_pathes["detail_path"] == own_path
  end

  def aides_path?
    RoutesList.all_pathes["aides_path"] == own_path
  end


  
end
