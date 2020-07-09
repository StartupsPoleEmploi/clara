require 'digest/sha1'
class PeconnectController < ApplicationController

  def index
    @built_url = ''
  end
  
  def post_question_1
  end

  def callback_question_2
  end

  def post_question_2
  end

  def callback

    fake = ExtractParam.new(params).call("fake")
    code = ExtractParam.new(params).call("code")
    base_url = "https://#{request.host}"    

    extraction_h = PeConnectExtraction.new.call(base_url, code, fake)

    asker = BuildAskerFromPeconnect.new.call(extraction_h.slice(:statut, :birth, :formation, :coord, :alloc))
    meta = BuildMetaFromPeconnect.new.call(extraction_h.slice(:info))

    save_asker(asker)

    hydrate_view({
      asker: asker,
      meta: meta
    })
  end

  def _actual_prenom(prenom_str)
    _upcase_first_letter(prenom_str.downcase)
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
    "Statut : #{str_libelle}"
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

  def _upcase_first_letter(str)
    str[0].upcase + str[1..-1]
  end

end


  
