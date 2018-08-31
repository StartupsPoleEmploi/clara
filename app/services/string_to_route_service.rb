class StringToRouteService

  attr_reader :fullpath, :verb

  def initialize(request)
    return unless request && request.respond_to?(:fullpath) && request.respond_to?(:request_method)
    @fullpath = request.fullpath
    @verb = request.request_method.downcase.to_sym
  end

  def path
    _recognize_path = recognize_path
    selected = routes.select do |key, value|
      value[:controller] == _recognize_path[:controller] && value[:action] == _recognize_path[:action]
    end
    "#{selected.keys[0]}_path"
  end

private

  def routes
    Hash[Rails.application.routes.routes.map { |r| [r.name, r.defaults] }]
  end

  def recognize_path
    Rails.application.routes.recognize_path(fullpath, method: verb)
  end
end
