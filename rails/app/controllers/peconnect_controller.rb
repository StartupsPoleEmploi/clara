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
    ap birth
    hydrate_view({
      "family_name" => info["family_name"],
      "given_name" => info["given_name"],
      "code_statut_individu" => statut["codeStatutIndividu"],
      "libelle_statut_individu" => statut["libelleStatutIndividu"],
      "date_de_naissance" => _actual_age(birth["dateDeNaissance"]),
    }.with_indifferent_access)
  end

  def _actual_age(str_birth)
    res = nil
    if str_birth
      dob = DateTime.strptime(str_birth, '%Y-%m-%dT%H:%M:%S%z')
      now = Date.today
      res = now.year - dob.year - (now.strftime('%m%d') < dob.strftime('%m%d') ? 1 : 0)
      # res = (Date.today.to_s(:number).to_i - birthday.to_date.to_s(:number).to_i)/1e4.to_i
    end
    res
  end

end


