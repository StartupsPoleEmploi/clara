class StringToRoute

  attr_reader :fullpath, :zeverb

  def initialize(fullpath, zeverb)
    @fullpath = fullpath
    @zeverb = zeverb
    # @request = request
    # @url = request.fullpath
    # p '- - - - - - - - - - - - - - @url- - - - - - - - - - - - - - - -' 
    # p @url.inspect
    # p ''
    # @verb = request.request_method.downcase
    # p '- - - - - - - - - - - - - - @verb- - - - - - - - - - - - - - - -' 
    # p @verb.inspect
    # p ''
  end

  def routes
    Hash[Rails.application.routes.routes.map { |r| [r.name, r.defaults] }]
    
    # Rails.application.routes.routes.to_a
  end

  def recognize_path
    Rails.application.routes.recognize_path(fullpath, method: zeverb)
  end

  def process
    _recognize_path = recognize_path
    selected = routes.select do |key, value|
      p value
      p _recognize_path
      value[:controller] == _recognize_path[:controller] && value[:action] == _recognize_path[:action]
    end
    selected.keys[0]
  end

  # def get_verb
  #   verb.to_sym
  # end

  def path
    # p '- - - - - - - - - - - - - - process- - - - - - - - - - - - - - - -' 
    # p process.na.inspect
    # p ''
    # process

    # "#{get_verb}_#{process.name}"
  end
end
