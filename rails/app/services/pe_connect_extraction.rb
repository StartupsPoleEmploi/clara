class PeConnectExtraction < PeConnectService

  def call(session, base_url, code, fake)
    res = {}
    
    if fake
      res = to_hash_object(fake)
    else
      pe_connect = PeConnectService.new
      tokens = PeConnectToken.new.call(base_url, code)
      access_token = tokens[:access_token]
      id_token = tokens[:id_token]

      info = pe_connect.call('https://api.emploi-store.fr/partenaire/peconnect-individu/v1/userinfo', access_token)
      statut = pe_connect.call('https://api.emploi-store.fr/partenaire/peconnect-statut/v1/statut', access_token)
      birth = pe_connect.call('https://api.emploi-store.fr/partenaire/peconnect-datenaissance/v1/etat-civil', access_token)
      formation = pe_connect.call('https://api.emploi-store.fr/partenaire/peconnect-formations/v1/formations', access_token)
      coord = pe_connect.call('https://api.emploi-store.fr/partenaire/peconnect-coordonnees/v1/coordonnees', access_token)
      alloc = pe_connect.call('https://api.emploi-store.fr/partenaire/peconnect-indemnisations/v1/indemnisation', access_token)

      session[:id_token] = id_token

      res = 
        {info: info, 
          statut: statut, 
          birth: birth, 
          formation: formation, 
          coord: coord, 
          alloc: alloc}
    end

    res
  end

  def to_hash_object(ruby_hash_text)
    JSON.parse(ruby_hash_text).symbolize_keys
  end


 end

# res example

# {:info=>
#   {"given_name"=>"ROBERT",
#    "family_name"=>"MARCHAND",
#    "gender"=>"male",
#    "idIdentiteExterne"=>"9bcb92d9-6a7b-464d-9b46-8c28af2b5af1",
#    "email"=>"emploistoredev@gmail.com",
#    "sub"=>"9bcb92d9-6a7b-464d-9b46-8c28af2b5af1",
#    "updated_at"=>0},
#  :statut=>
#   {"codeStatutIndividu"=>"0",
#    "libelleStatutIndividu"=>"Non demandeur d’emploi"},
#  :birth=>
#   {"codeCivilite"=>nil,
#    "libelleCivilite"=>nil,
#    "nomPatronymique"=>nil,
#    "nomMarital"=>nil,
#    "prenom"=>nil,
#    "dateDeNaissance"=>"1976-03-12T00:00:00+01:00"},
#  :formation=>
#   [{"anneeFin"=>2016,
#     "description"=>"c'était bien :)",
#     "diplomeObtenu"=>true,
#     "domaine"=>{"code"=>"15066", "libelle"=>"Efficacité personnelle"},
#     "etranger"=>false,
#     "intitule"=>"product manager d'élite"}],
#  :coord=>
#   {"adresse1"=>"APPARTEMENT 45",
#    "adresse2"=>"RESIDENCE DU SOLEIL",
#    "adresse3"=>"BATIMENT B",
#    "adresse4"=>"34 ALLEE DU 6 JUIN",
#    "codePostal"=>"44230",
#    "codeINSEE"=>"44190",
#    "libelleCommune"=>"ST SEBASTIEN SUR LOIRE",
#    "codePays"=>"FR",
#    "libellePays"=>"FRANCE"},
#  :alloc=>
#   {"beneficiairePrestationSolidarite"=>false,
#    "beneficiaireAssuranceChomage"=>false}}




# Possible encoding at https://meyerweb.com/eric/tools/dencoder/

# {
#   "statut": {
#     "codeStatutIndividu": "0",
#     "libelleStatutIndividu": "Non demandeur d’emploi"
#   },
#   "birth": {
#     "codeCivilite": null,
#     "libelleCivilite": null,
#     "nomPatronymique": null,
#     "nomMarital": null,
#     "prenom": null,
#     "dateDeNaissance": "1976-03-12T00:00:00+01:00"
#   },
#   "formation": [
#     {
#       "anneeFin": 2016,
#       "description": "c'était bien :)",
#       "diplomeObtenu": true,
#       "domaine": {
#         "code": "15066",
#         "libelle": "Efficacité personnelle"
#       },
#       "etranger": false,
#       "intitule": "product manager d'élite"
#     }
#   ],
#   "coord": {
#     "adresse1": "APPARTEMENT 45",
#     "adresse2": "RESIDENCE DU SOLEIL",
#     "adresse3": "BATIMENT B",
#     "adresse4": "34 ALLEE DU 6 JUIN",
#     "codePostal": "44230",
#     "codeINSEE": "44190",
#     "libelleCommune": "ST SEBASTIEN SUR LOIRE",
#     "codePays": "FR",
#     "libellePays": "FRANCE"
#   },
#   "alloc": {
#     "beneficiairePrestationSolidarite": false,
#     "beneficiaireAssuranceChomage": false
#   }
# }

# Inscrit, 44 ans, pasdepresta, Coueron, pasdeformation
# https://dboureau.beta.pole-emploi.fr/peconnect_callback?fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%221%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%5D%2C%0A%22coord%22%3A%7B%0A%22adresse1%22%3A%223%20RUE%20DES%20FLANDRES%22%2C%0A%22codePostal%22%3A%2244220%22%2C%0A%22codeINSEE%22%3A%2244047%22%2C%0A%22libelleCommune%22%3A%22COUERON%22%2C%0A%22codePays%22%3A%22FR%22%2C%0A%22libellePays%22%3A%22FRANCE%22%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Afalse%2C%0A%22beneficiaireAssuranceChomage%22%3Afalse%0A%7D%0A%7D
# https://clara.beta.pole-emploi.fr/peconnect_callback?fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%221%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%5D%2C%0A%22coord%22%3A%7B%0A%22adresse1%22%3A%223%20RUE%20DES%20FLANDRES%22%2C%0A%22codePostal%22%3A%2244220%22%2C%0A%22codeINSEE%22%3A%2244047%22%2C%0A%22libelleCommune%22%3A%22COUERON%22%2C%0A%22codePays%22%3A%22FR%22%2C%0A%22libellePays%22%3A%22FRANCE%22%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Afalse%2C%0A%22beneficiaireAssuranceChomage%22%3Afalse%0A%7D%0A%7D
# 
# Inscrit, 44 ans, ARE ASP, pasdecommune, pasdeformation
# https://dboureau.beta.pole-emploi.fr/peconnect_callback?fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%221%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%5D%2C%0A%22coord%22%3A%7B%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Afalse%2C%0A%22beneficiaireAssuranceChomage%22%3Atrue%0A%7D%0A%7D
# https://clara.beta.pole-emploi.fr/peconnect_callback?fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%221%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%5D%2C%0A%22coord%22%3A%7B%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Afalse%2C%0A%22beneficiaireAssuranceChomage%22%3Atrue%0A%7D%0A%7D
# 

# Non Inscrit, 44 ans, ARE ASP, St-Seb, Bac +3
# https://dboureau.beta.pole-emploi.fr/peconnect_callback?fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%220%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%7B%0A%22anneeFin%22%3A2013%2C%0A%22description%22%3A%22Aprentissagedel%27int%C3%A9grationetdelagestiondesenvironnemnts%22%2C%0A%22diplomeObtenu%22%3Atrue%2C%0A%22domaine%22%3A%7B%0A%22code%22%3A%2231082%22%2C%0A%22libelle%22%3A%22Int%C3%A9grationinformatique%22%0A%7D%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22d%C3%AEplomeing%C3%A9nieur%22%2C%0A%22lieu%22%3A%22AfriqueduSud%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV3%22%2C%0A%22libelle%22%3A%22Bac%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22AFS%22%2C%0A%22libelle%22%3A%22Aucuneformationscolaire%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV2%22%2C%0A%22libelle%22%3A%22Bac%2B2%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV1%22%2C%0A%22libelle%22%3A%22Bac%2B5%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV4%22%2C%0A%22libelle%22%3A%22Bac%2B1%22%0A%7D%0A%7D%0A%5D%2C%0A%22coord%22%3A%7B%0A%22adresse1%22%3A%22APPARTEMENT45%22%2C%0A%22adresse2%22%3A%22RESIDENCEDUSOLEIL%22%2C%0A%22adresse3%22%3A%22BATIMENTB%22%2C%0A%22adresse4%22%3A%2234ALLEEDU6JUIN%22%2C%0A%22codePostal%22%3A%2244230%22%2C%0A%22codeINSEE%22%3A%2244190%22%2C%0A%22libelleCommune%22%3A%22STSEBASTIENSURLOIRE%22%2C%0A%22codePays%22%3A%22FR%22%2C%0A%22libellePays%22%3A%22FRANCE%22%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Afalse%2C%0A%22beneficiaireAssuranceChomage%22%3Afalse%0A%7D%0A%7D
# https://clara.beta.pole-emploi.fr/peconnect_callback?fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%220%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%7B%0A%22anneeFin%22%3A2013%2C%0A%22description%22%3A%22Aprentissagedel%27int%C3%A9grationetdelagestiondesenvironnemnts%22%2C%0A%22diplomeObtenu%22%3Atrue%2C%0A%22domaine%22%3A%7B%0A%22code%22%3A%2231082%22%2C%0A%22libelle%22%3A%22Int%C3%A9grationinformatique%22%0A%7D%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22d%C3%AEplomeing%C3%A9nieur%22%2C%0A%22lieu%22%3A%22AfriqueduSud%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV3%22%2C%0A%22libelle%22%3A%22Bac%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22AFS%22%2C%0A%22libelle%22%3A%22Aucuneformationscolaire%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV2%22%2C%0A%22libelle%22%3A%22Bac%2B2%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV1%22%2C%0A%22libelle%22%3A%22Bac%2B5%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV4%22%2C%0A%22libelle%22%3A%22Bac%2B1%22%0A%7D%0A%7D%0A%5D%2C%0A%22coord%22%3A%7B%0A%22adresse1%22%3A%22APPARTEMENT45%22%2C%0A%22adresse2%22%3A%22RESIDENCEDUSOLEIL%22%2C%0A%22adresse3%22%3A%22BATIMENTB%22%2C%0A%22adresse4%22%3A%2234ALLEEDU6JUIN%22%2C%0A%22codePostal%22%3A%2244230%22%2C%0A%22codeINSEE%22%3A%2244190%22%2C%0A%22libelleCommune%22%3A%22STSEBASTIENSURLOIRE%22%2C%0A%22codePays%22%3A%22FR%22%2C%0A%22libellePays%22%3A%22FRANCE%22%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Afalse%2C%0A%22beneficiaireAssuranceChomage%22%3Afalse%0A%7D%0A%7D


# Inscrit, 44 ans, ARE ASP, St-Seb, Bac +3
# fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%221%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%7B%0A%22anneeFin%22%3A2013%2C%0A%22description%22%3A%22Aprentissagedel%27int%C3%A9grationetdelagestiondesenvironnemnts%22%2C%0A%22diplomeObtenu%22%3Atrue%2C%0A%22domaine%22%3A%7B%0A%22code%22%3A%2231082%22%2C%0A%22libelle%22%3A%22Int%C3%A9grationinformatique%22%0A%7D%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22d%C3%AEplomeing%C3%A9nieur%22%2C%0A%22lieu%22%3A%22AfriqueduSud%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV3%22%2C%0A%22libelle%22%3A%22Bac%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22AFS%22%2C%0A%22libelle%22%3A%22Aucuneformationscolaire%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV2%22%2C%0A%22libelle%22%3A%22Bac%2B2%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV1%22%2C%0A%22libelle%22%3A%22Bac%2B5%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV4%22%2C%0A%22libelle%22%3A%22Bac%2B1%22%0A%7D%0A%7D%0A%5D%2C%0A%22coord%22%3A%7B%0A%22adresse1%22%3A%22APPARTEMENT45%22%2C%0A%22adresse2%22%3A%22RESIDENCEDUSOLEIL%22%2C%0A%22adresse3%22%3A%22BATIMENTB%22%2C%0A%22adresse4%22%3A%2234ALLEEDU6JUIN%22%2C%0A%22codePostal%22%3A%2244230%22%2C%0A%22codeINSEE%22%3A%2244190%22%2C%0A%22libelleCommune%22%3A%22STSEBASTIENSURLOIRE%22%2C%0A%22codePays%22%3A%22FR%22%2C%0A%22libellePays%22%3A%22FRANCE%22%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Atrue%2C%0A%22beneficiaireAssuranceChomage%22%3Afalse%0A%7D%0A%7D
# https://clara.beta.pole-emploi.fr/peconnect_callback?fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%221%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%7B%0A%22anneeFin%22%3A2013%2C%0A%22description%22%3A%22Aprentissagedel%27int%C3%A9grationetdelagestiondesenvironnemnts%22%2C%0A%22diplomeObtenu%22%3Atrue%2C%0A%22domaine%22%3A%7B%0A%22code%22%3A%2231082%22%2C%0A%22libelle%22%3A%22Int%C3%A9grationinformatique%22%0A%7D%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22d%C3%AEplomeing%C3%A9nieur%22%2C%0A%22lieu%22%3A%22AfriqueduSud%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV3%22%2C%0A%22libelle%22%3A%22Bac%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22AFS%22%2C%0A%22libelle%22%3A%22Aucuneformationscolaire%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV2%22%2C%0A%22libelle%22%3A%22Bac%2B2%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV1%22%2C%0A%22libelle%22%3A%22Bac%2B5%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV4%22%2C%0A%22libelle%22%3A%22Bac%2B1%22%0A%7D%0A%7D%0A%5D%2C%0A%22coord%22%3A%7B%0A%22adresse1%22%3A%22APPARTEMENT45%22%2C%0A%22adresse2%22%3A%22RESIDENCEDUSOLEIL%22%2C%0A%22adresse3%22%3A%22BATIMENTB%22%2C%0A%22adresse4%22%3A%2234ALLEEDU6JUIN%22%2C%0A%22codePostal%22%3A%2244230%22%2C%0A%22codeINSEE%22%3A%2244190%22%2C%0A%22libelleCommune%22%3A%22STSEBASTIENSURLOIRE%22%2C%0A%22codePays%22%3A%22FR%22%2C%0A%22libellePays%22%3A%22FRANCE%22%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Atrue%2C%0A%22beneficiaireAssuranceChomage%22%3Afalse%0A%7D%0A%7D
# https://dboureau.beta.pole-emploi.fr/peconnect_callback?fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%221%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%7B%0A%22anneeFin%22%3A2013%2C%0A%22description%22%3A%22Aprentissagedel%27int%C3%A9grationetdelagestiondesenvironnemnts%22%2C%0A%22diplomeObtenu%22%3Atrue%2C%0A%22domaine%22%3A%7B%0A%22code%22%3A%2231082%22%2C%0A%22libelle%22%3A%22Int%C3%A9grationinformatique%22%0A%7D%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22d%C3%AEplomeing%C3%A9nieur%22%2C%0A%22lieu%22%3A%22AfriqueduSud%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV3%22%2C%0A%22libelle%22%3A%22Bac%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22AFS%22%2C%0A%22libelle%22%3A%22Aucuneformationscolaire%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV2%22%2C%0A%22libelle%22%3A%22Bac%2B2%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV1%22%2C%0A%22libelle%22%3A%22Bac%2B5%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV4%22%2C%0A%22libelle%22%3A%22Bac%2B1%22%0A%7D%0A%7D%0A%5D%2C%0A%22coord%22%3A%7B%0A%22adresse1%22%3A%22APPARTEMENT45%22%2C%0A%22adresse2%22%3A%22RESIDENCEDUSOLEIL%22%2C%0A%22adresse3%22%3A%22BATIMENTB%22%2C%0A%22adresse4%22%3A%2234ALLEEDU6JUIN%22%2C%0A%22codePostal%22%3A%2244230%22%2C%0A%22codeINSEE%22%3A%2244190%22%2C%0A%22libelleCommune%22%3A%22STSEBASTIENSURLOIRE%22%2C%0A%22codePays%22%3A%22FR%22%2C%0A%22libellePays%22%3A%22FRANCE%22%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Atrue%2C%0A%22beneficiaireAssuranceChomage%22%3Afalse%0A%7D%0A%7D

# Inscrit, 44 ans, pas de type d'alloc, St-Seb, Bac +3
# fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%221%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%7B%0A%22anneeFin%22%3A2013%2C%0A%22description%22%3A%22Aprentissagedel%27int%C3%A9grationetdelagestiondesenvironnemnts%22%2C%0A%22diplomeObtenu%22%3Atrue%2C%0A%22domaine%22%3A%7B%0A%22code%22%3A%2231082%22%2C%0A%22libelle%22%3A%22Int%C3%A9grationinformatique%22%0A%7D%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22d%C3%AEplomeing%C3%A9nieur%22%2C%0A%22lieu%22%3A%22AfriqueduSud%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV3%22%2C%0A%22libelle%22%3A%22Bac%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22AFS%22%2C%0A%22libelle%22%3A%22Aucuneformationscolaire%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV2%22%2C%0A%22libelle%22%3A%22Bac%2B2%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV1%22%2C%0A%22libelle%22%3A%22Bac%2B5%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV4%22%2C%0A%22libelle%22%3A%22Bac%2B1%22%0A%7D%0A%7D%0A%5D%2C%0A%22coord%22%3A%7B%0A%22adresse1%22%3A%22APPARTEMENT45%22%2C%0A%22adresse2%22%3A%22RESIDENCEDUSOLEIL%22%2C%0A%22adresse3%22%3A%22BATIMENTB%22%2C%0A%22adresse4%22%3A%2234ALLEEDU6JUIN%22%2C%0A%22codePostal%22%3A%2244230%22%2C%0A%22codeINSEE%22%3A%2244190%22%2C%0A%22libelleCommune%22%3A%22STSEBASTIENSURLOIRE%22%2C%0A%22codePays%22%3A%22FR%22%2C%0A%22libellePays%22%3A%22FRANCE%22%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Afalse%2C%0A%22beneficiaireAssuranceChomage%22%3Afalse%0A%7D%0A%7D
# https://dboureau.beta.pole-emploi.fr/peconnect_callback?fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%221%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%7B%0A%22anneeFin%22%3A2013%2C%0A%22description%22%3A%22Aprentissagedel%27int%C3%A9grationetdelagestiondesenvironnemnts%22%2C%0A%22diplomeObtenu%22%3Atrue%2C%0A%22domaine%22%3A%7B%0A%22code%22%3A%2231082%22%2C%0A%22libelle%22%3A%22Int%C3%A9grationinformatique%22%0A%7D%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22d%C3%AEplomeing%C3%A9nieur%22%2C%0A%22lieu%22%3A%22AfriqueduSud%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV3%22%2C%0A%22libelle%22%3A%22Bac%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22AFS%22%2C%0A%22libelle%22%3A%22Aucuneformationscolaire%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV2%22%2C%0A%22libelle%22%3A%22Bac%2B2%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV1%22%2C%0A%22libelle%22%3A%22Bac%2B5%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV4%22%2C%0A%22libelle%22%3A%22Bac%2B1%22%0A%7D%0A%7D%0A%5D%2C%0A%22coord%22%3A%7B%0A%22adresse1%22%3A%22APPARTEMENT45%22%2C%0A%22adresse2%22%3A%22RESIDENCEDUSOLEIL%22%2C%0A%22adresse3%22%3A%22BATIMENTB%22%2C%0A%22adresse4%22%3A%2234ALLEEDU6JUIN%22%2C%0A%22codePostal%22%3A%2244230%22%2C%0A%22codeINSEE%22%3A%2244190%22%2C%0A%22libelleCommune%22%3A%22STSEBASTIENSURLOIRE%22%2C%0A%22codePays%22%3A%22FR%22%2C%0A%22libellePays%22%3A%22FRANCE%22%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Afalse%2C%0A%22beneficiaireAssuranceChomage%22%3Afalse%0A%7D%0A%7D
# https://clara.beta.pole-emploi.fr/peconnect_callback?fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%221%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%7B%0A%22anneeFin%22%3A2013%2C%0A%22description%22%3A%22Aprentissagedel%27int%C3%A9grationetdelagestiondesenvironnemnts%22%2C%0A%22diplomeObtenu%22%3Atrue%2C%0A%22domaine%22%3A%7B%0A%22code%22%3A%2231082%22%2C%0A%22libelle%22%3A%22Int%C3%A9grationinformatique%22%0A%7D%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22d%C3%AEplomeing%C3%A9nieur%22%2C%0A%22lieu%22%3A%22AfriqueduSud%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV3%22%2C%0A%22libelle%22%3A%22Bac%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22AFS%22%2C%0A%22libelle%22%3A%22Aucuneformationscolaire%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV2%22%2C%0A%22libelle%22%3A%22Bac%2B2%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV1%22%2C%0A%22libelle%22%3A%22Bac%2B5%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV4%22%2C%0A%22libelle%22%3A%22Bac%2B1%22%0A%7D%0A%7D%0A%5D%2C%0A%22coord%22%3A%7B%0A%22adresse1%22%3A%22APPARTEMENT45%22%2C%0A%22adresse2%22%3A%22RESIDENCEDUSOLEIL%22%2C%0A%22adresse3%22%3A%22BATIMENTB%22%2C%0A%22adresse4%22%3A%2234ALLEEDU6JUIN%22%2C%0A%22codePostal%22%3A%2244230%22%2C%0A%22codeINSEE%22%3A%2244190%22%2C%0A%22libelleCommune%22%3A%22STSEBASTIENSURLOIRE%22%2C%0A%22codePays%22%3A%22FR%22%2C%0A%22libellePays%22%3A%22FRANCE%22%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Afalse%2C%0A%22beneficiaireAssuranceChomage%22%3Afalse%0A%7D%0A%7D

# Inscrit, 44 ans, prestasolidarite, St-Seb, Bac +3
# fake=%7B%0A%22info%22%3A%7B%0A%22given_name%22%3A%22David%22%0A%7D%2C%0A%22statut%22%3A%7B%0A%22codeStatutIndividu%22%3A%221%22%2C%0A%22libelleStatutIndividu%22%3A%22Nondemandeurd%E2%80%99emploi%22%0A%7D%2C%0A%22birth%22%3A%7B%0A%22codeCivilite%22%3Anull%2C%0A%22libelleCivilite%22%3Anull%2C%0A%22nomPatronymique%22%3Anull%2C%0A%22nomMarital%22%3Anull%2C%0A%22prenom%22%3Anull%2C%0A%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%7D%2C%0A%22formation%22%3A%5B%0A%7B%0A%22anneeFin%22%3A2013%2C%0A%22description%22%3A%22Aprentissagedel%27int%C3%A9grationetdelagestiondesenvironnemnts%22%2C%0A%22diplomeObtenu%22%3Atrue%2C%0A%22domaine%22%3A%7B%0A%22code%22%3A%2231082%22%2C%0A%22libelle%22%3A%22Int%C3%A9grationinformatique%22%0A%7D%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22d%C3%AEplomeing%C3%A9nieur%22%2C%0A%22lieu%22%3A%22AfriqueduSud%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV3%22%2C%0A%22libelle%22%3A%22Bac%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22AFS%22%2C%0A%22libelle%22%3A%22Aucuneformationscolaire%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV2%22%2C%0A%22libelle%22%3A%22Bac%2B2%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Afalse%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV1%22%2C%0A%22libelle%22%3A%22Bac%2B5%22%0A%7D%0A%7D%2C%0A%7B%0A%22diplomeObtenu%22%3Atrue%2C%0A%22etranger%22%3Atrue%2C%0A%22intitule%22%3A%22BAC%22%2C%0A%22niveau%22%3A%7B%0A%22code%22%3A%22NV4%22%2C%0A%22libelle%22%3A%22Bac%2B1%22%0A%7D%0A%7D%0A%5D%2C%0A%22coord%22%3A%7B%0A%22adresse1%22%3A%22APPARTEMENT45%22%2C%0A%22adresse2%22%3A%22RESIDENCEDUSOLEIL%22%2C%0A%22adresse3%22%3A%22BATIMENTB%22%2C%0A%22adresse4%22%3A%2234ALLEEDU6JUIN%22%2C%0A%22codePostal%22%3A%2244230%22%2C%0A%22codeINSEE%22%3A%2244190%22%2C%0A%22libelleCommune%22%3A%22STSEBASTIENSURLOIRE%22%2C%0A%22codePays%22%3A%22FR%22%2C%0A%22libellePays%22%3A%22FRANCE%22%0A%7D%2C%0A%22alloc%22%3A%7B%0A%22beneficiairePrestationSolidarite%22%3Atrue%2C%0A%22beneficiaireAssuranceChomage%22%3Afalse%0A%7D%0A%7D
