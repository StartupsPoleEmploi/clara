require 'digest/sha1'
class PeconnectController < ApplicationController

  def index
    @built_url = ''
  end

  def callback

    code = ExtractParam.new(params).call("code")
    base_url = "https://#{request.host}"    

    access_token = PeConnectAccessToken.new.call(base_url, code)

    info = PeConnectInfo.new.call(access_token)
    statut = PeConnectStatut.new.call(access_token)
    birth = PeConnectBirthdate.new.call(access_token)
    ap '*************************************************************************************'
    ap info
    ap statut
    hydrate_view({
      "family_name" => info["family_name"],
      "given_name" => info["given_name"],
      "code_statut_individu" => statut["codeStatutIndividu"],
      "libelle_statut_individu" => statut["libelleStatutIndividu"],
      "date_de_naissance" => birth["dateDeNaissance"],
    }.with_indifferent_access)
  end

end


