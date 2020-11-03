require 'yaml'
require 'asker'

class ApplicationController < ActionController::Base
  include Clearance::Controller
  
  protect_from_forgery with: :exception
  
  before_action :check_cache

  # back button that works, see http://jacopretorius.net/2014/01/force-page-to-reload-on-browser-back-in-rails.html
  before_action :set_cache_headers
  # See https://stackoverflow.com/a/38003702/2595513
  after_action :set_response_language_header

  skip_before_action :verify_authenticity_token if Rails.env.development?

  def check_cache
    unless File.file?(Rails.root.join('public','activated_models.txt'))
      ActivatedModelsGeneratorService.new.regenerate
    end
  end

  def sign_in(user)
    session.clear
    super
  end

  def set_response_language_header
      response.headers["Content-Language"] = "fr-FR"
  end
  
  def my_redirect_to(url)
    # See https://github.com/turbolinks/turbolinks-rails/pull/41
    redirect_to url, {turbolinks: :advance}
  end

  def save_asker(asker=@asker)
    session[:asker] = asker.attributes.to_json.to_s if asker
  end

  def require_asker
    @asker = RequireAsker.new.call(session)
  end

  def hydrate_view(stuff)
    @raw_rendered = stuff
    render locals: stuff
  end

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
