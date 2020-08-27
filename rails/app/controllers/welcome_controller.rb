class WelcomeController < ApplicationController

  # skip_before_action :verify_authenticity_token if Rails.env.development?
  # skip_before_action :verify_authenticity_token, :only => [:disconnect_from_peconnect]

  def index
    SendRecallJob.perform_later(request && request.params[:force] == "true", request.try(:original_url))
    clean_asker_params
    all_home_filters = Filter.homable.map { |e| {name: e.name, slug: e.slug, url: e.illustration.url, ordre: e.ordre_affichage_home || 999} }
    view_params = Rails.cache.fetch("view_data_for_welcome_page", expires_in: 1.hour) do
      res = {
        nb_of_active_aids:  Aid.activated.count,
        type_aides:         ContractType.aides.map{|e| e.attributes},
        type_dispositifs:   ContractType.dispositifs.map{|e| e.attributes},
        all_home_filters:   all_home_filters,
        url_of_peconnect:   PeConnectUrl.new.call("https://#{request.host}"),
        is_peconnect_activated: PeconnectActivation.new.get_value
      }
      res
    end
    hydrate_view(view_params)
  end

  def start_peconnect
    session.clear
    url_of_peconnect = PeConnectUrl.new.call("https://#{request.host}")
    pe_connect_base_url = url_of_peconnect.start_with?('?') ? url_of_peconnect : ('?' + url_of_peconnect)
    redirect_to "https://authentification-candidat.pole-emploi.fr/connexion/oauth2/authorize#{pe_connect_base_url}"
  end

  def start_wizard
    clean_asker_params
    my_redirect_to QuestionManager.new.getNextPath
  end

  def disconnect_from_peconnect
    old_token = session[:id_token]
    session.clear
    ap 'go !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'

    if params[:json]
      ap 'JSON !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
      render json: {redirection_url: "https://authentification-candidat.pole-emploi.fr/compte/deconnexion?id_token_hint=#{old_token}&redirect_uri=https://#{request.host}"}
    else
      ap 'HTML !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
      redirect_to "https://authentification-candidat.pole-emploi.fr/compte/deconnexion?id_token_hint=#{old_token}&redirect_uri=https://#{request.host}"
    end
  end

  def accept_all_cookies
    CookiePreference.new(session).accept_all_cookies
  end

  def terms
    all_home_filters = Filter.homable.map { |e| {credit: e.author, name: e.name, slug: e.slug, url: e.illustration.url, ordre: e.ordre_affichage_home || 999} }
    hydrate_view({
      all_home_filters: all_home_filters
    })
  end

  def accessibility
  end

  private
  def clean_asker_params
    session.delete :asker
  end



  



end
