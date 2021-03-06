class GetCurrentPathService

  def initialize(a_request)
    @a_request = a_request
  end

  def call
    res = ""
    # Stolen from http://hackingoff.com/blog/generate-rails-sitemap-from-routes/
    routes = Rails.application.routes.routes.map do |route|
      {
        alias: route.name,
        path: route.path.spec.to_s,
        controller: route.defaults[:controller],
        action: route.defaults[:action]
      }
    end

    begin
      current = Rails.application.routes.recognize_path(@a_request.env['PATH_INFO'])

      choice = routes.find do |route|
        route[:controller] == current[:controller] && route[:action] == current[:action]
      end

      res = choice[:alias] + "_path"
    rescue Exception
      res = "not_found"
    end
  end

end
