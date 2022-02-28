require 'yaml'
require 'asker'

class ApplicationController < ActionController::Base
  include Clearance::Controller
  
  protect_from_forgery with: :exception
  
  before_action :check_redirect

  before_action :check_cache

  # back button that works, see http://jacopretorius.net/2014/01/force-page-to-reload-on-browser-back-in-rails.html
  before_action :set_cache_headers
  # See https://stackoverflow.com/a/38003702/2595513
  after_action :set_response_language_header

  skip_before_action :verify_authenticity_token if Rails.env.development?


  def check_redirect
    if request.get?
      if request.path.in?(_do_not_redirect)
        # Do nothing
      elsif request.path.include?('/admin')
        # Do nothing
      elsif request.path.include?('/api/')
        # Do nothing
      elsif request.path.include?('password')
        # Do nothing
      elsif request.path.include?('teaspoon')
        # Do nothing
      else
        redirection_url = _redirection_table[request.path]
        if redirection_url.present?
          redirect_to redirection_url
        else
          redirect_to "https://mes-aides.pole-emploi.fr/"
        end
      end

    end
  end


  def _do_not_redirect
    # Do not redirect password pathes also
    # Do not redirect API
    # Do not redirect admin
    [
      "/sign_in",
      "/sign_up",
      "/sign_out",
      "/logs",
      "/sidekiq",
      "/letter_opener",
    ]
  end
  def _redirection_table
    {
      "/aides/type/aide-a-la-mobilite" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/aide-au-financement-du-permis-b-pour-les-apprentis" => "https://mes-aides.pole-emploi.fr/etat/apprentis-majeurs",
      "/aides/detail/aides-a-la-mobilite-dans-la-region-hauts-de-france" => "https://mes-aides.pole-emploi.fr/region-hauts-de-france/aide-regionale-aide-au-permis-de-conduire-pour-l-insertion-professionnelle-des-jeunes-",
      "/aides/detail/pret-mobilite-de-l-adie" => "https://mes-aides.pole-emploi.fr/l-adie-et-l-etat/pret-mobilite-de-l-adie",
      "/aides/detail/aide-au-parcours-vers-l-emploi" => "https://mes-aides.pole-emploi.fr/agefiph/aide-a-la-formation-dans-le-cadre-du-parcours-vers-l-emploi",
      "/aides/detail/aide-a-la-mobilite-agefiph" => "https://mes-aides.pole-emploi.fr/agefiph/aide-a-la-formation-dans-le-cadre-du-parcours-vers-l-emploi",
      "/aides/detail/aide-a-la-mobilite-frais-de-deplacement-bon-de-transport" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/aides-action-logement" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/aide-a-la-mobilite-frais-de-deplacement-bon-de-reservation" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/aide-a-la-mobilite-frais-de-deplacement" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/aide-a-la-mobilite-frais-d-hebergement" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/plateforme-mobilite-montauban-services" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite/annuaires/plateformes-mobilite",
      "/aides/detail/aide-a-la-mobilite-frais-de-repas" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/rezo-pouce" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/billet-pass-emploi" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/illico-solidaire" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/coup-de-pouce" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/programme-solidaire-mana-ara" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/mobilize" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/aide-au-demenagement-pour-les-artistes-ou-technicien-ne-s-du-spectacle" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/aide-a-la-mobilite-professionnelle-des-artistes-et-technicien-ne-s-du-spectacle" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/aide-aux-depenses-quotidiennes-pendant-une-formation-pour-les-artistes-et-technicien-ne-s-du-spectacle" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/bon-tarif-reduit-recherche-emploi-bourgogne-franche-comte" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
      "/aides/detail/plateforme-mobilite-mayenne" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite/annuaires/plateformes-mobilite",
      "/aides/detail/carte-mobi-pays-de-la-loire" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite"
    }
  end


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
