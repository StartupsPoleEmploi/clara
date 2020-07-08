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
    formation = PeConnectFormation.new.call(access_token)
    coord = PeConnectCoord.new.call(access_token)
    alloc = PeConnectAlloc.new.call(access_token)
    ap '*************************************************************************************'
    ap info
    ap statut
    ap birth
    ap formation
    ap coord
    ap alloc
    hydrate_view({
      "libelle_statut_individu" => _actual_libelle(statut["libelleStatutIndividu"]),
      "date_de_naissance" => _actual_age(birth["dateDeNaissance"]),
      "niveau_formation" => _actual_formation(formation),
      "coord" => _actual_coord(coord),
      "alloc" => _actual_allocation(alloc)
    }.with_indifferent_access)
  end

  def _actual_formation(h_formation)
    libelle_formation = h_formation.try(:[], 0).try(:[], "niveau").try(:[], "libelle")
    res = libelle_formation || "non défini"
    "Diplôme obtenu le plus haut : #{res}"
  end

  def _actual_coord(h_coord)
    res = 'Non définie'
    if h_coord.try(:[], "libelleCommune")
      res = h_coord.try(:[], "codePostal") + ' ' + h_coord.try(:[], "libelleCommune")
    end
    "Commune de résidence : #{res}"
  end

  def _actual_libelle(str_libelle)
    "Inscrit à Pôle Emploi : #{str_libelle}"
  end

  def _actual_age(str_birth)
    res = nil
    if str_birth
      dob = DateTime.strptime(str_birth, '%Y-%m-%dT%H:%M:%S%z')
      now = Date.today
      res = now.year - dob.year - (now.strftime('%m%d') < dob.strftime('%m%d') ? 1 : 0)
    end
    "Vous avez #{res} ans"
  end

  def _actual_allocation(obj_allocation)
    res = 'Aucune'
    if obj_allocation.is_a?(Hash)
      if obj_allocation["beneficiairePrestationSolidarite"] == true
        res = "Bénéficiaire d'un minima social (ASS, AAH, RSA, AER)"
      elsif obj_allocation["beneficiairePrestationSolidarite"] == true
        res = "Bénéficiaire de l'assurance chômage"
      end
    end
    "Allocation perçue : #{res}"
  end

end


  
