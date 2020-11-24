class WelcomeController < ApplicationController

  def index
    clean_asker_params
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
    res = DisconnectFromPeconnect.new.call(request, session, params)
    public_send(res[:method], res[:arg])
  end

  def accept_all_cookies
    CookiePreference.new(session).accept_all_cookies
  end

  def all_home_filters
    Filter.with_aid_attached.map do |e| 
      {
        credit: e.author, 
        name: e.name, 
        slug: e.slug, 
        avatar: e.avatar.attached? ? e.avatar : nil , 
        ordre: e.ordre_affichage_home || 999
      }
    end
  end
  
  def terms
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
