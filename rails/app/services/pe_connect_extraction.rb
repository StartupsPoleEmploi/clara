class PeConnectExtraction < PeConnectService

  def call(base_url, code, fake)
    res = {}
    
    if fake
      res = to_hash_object(fake)
    else
      access_token = PeConnectAccessToken.new.call(base_url, code)
      info = PeConnectInfo.new.call(access_token)
      statut = PeConnectStatut.new.call(access_token)
      birth = PeConnectBirthdate.new.call(access_token)
      formation = PeConnectFormation.new.call(access_token)
      coord = PeConnectCoord.new.call(access_token)
      alloc = PeConnectAlloc.new.call(access_token)

      res = 
        {info: info, 
          statut: statut, 
          birth: birth, 
          formation: formation, 
          coord: coord, 
          alloc: alloc}
    end
    p '- - - - - - - - - - - - - - res- - - - - - - - - - - - - - - -' 
    pp res
    p ''

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

# %7B%0A%20%20%22info%22%3A%20%7B%0A%20%20%20%20%22given_name%22%3A%20%22David%22%0A%20%20%7D%2C%0A%20%20%22statut%22%3A%20%7B%0A%20%20%20%20%22codeStatutIndividu%22%3A%20%220%22%2C%0A%20%20%20%20%22libelleStatutIndividu%22%3A%20%22Non%20demandeur%20d%E2%80%99emploi%22%0A%20%20%7D%2C%0A%20%20%22birth%22%3A%20%7B%0A%20%20%20%20%22codeCivilite%22%3A%20null%2C%0A%20%20%20%20%22libelleCivilite%22%3A%20null%2C%0A%20%20%20%20%22nomPatronymique%22%3A%20null%2C%0A%20%20%20%20%22nomMarital%22%3A%20null%2C%0A%20%20%20%20%22prenom%22%3A%20null%2C%0A%20%20%20%20%22dateDeNaissance%22%3A%20%221976-03-12T00%3A00%3A00%2B01%3A00%22%0A%20%20%7D%2C%0A%20%20%22formation%22%3A%20%5B%0A%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%22anneeFin%22%3A%202013%2C%0A%20%20%20%20%20%20%20%20%22description%22%3A%20%22Aprentissage%20de%20l%27int%C3%A9gration%20et%20de%20la%20gestion%20des%20environnemnts%22%2C%0A%20%20%20%20%20%20%20%20%22diplomeObtenu%22%3A%20true%2C%0A%20%20%20%20%20%20%20%20%22domaine%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%22code%22%3A%20%2231082%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%22libelle%22%3A%20%22Int%C3%A9gration%20informatique%22%0A%20%20%20%20%20%20%20%20%7D%2C%0A%20%20%20%20%20%20%20%20%22etranger%22%3A%20true%2C%0A%20%20%20%20%20%20%20%20%22intitule%22%3A%20%22d%C3%AEplome%20ing%C3%A9nieur%22%2C%0A%20%20%20%20%20%20%20%20%22lieu%22%3A%20%22Afrique%20du%20Sud%22%2C%0A%20%20%20%20%20%20%20%20%22niveau%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%22code%22%3A%20%22NV3%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%22libelle%22%3A%20%22Bac%22%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%2C%0A%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%22diplomeObtenu%22%3A%20false%2C%0A%20%20%20%20%20%20%20%20%22etranger%22%3A%20true%2C%0A%20%20%20%20%20%20%20%20%22intitule%22%3A%20%22BAC%22%2C%0A%20%20%20%20%20%20%20%20%22niveau%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%22code%22%3A%20%22AFS%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%22libelle%22%3A%20%22Aucune%20formation%20scolaire%22%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%2C%0A%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%22diplomeObtenu%22%3A%20true%2C%0A%20%20%20%20%20%20%20%20%22etranger%22%3A%20true%2C%0A%20%20%20%20%20%20%20%20%22intitule%22%3A%20%22BAC%22%2C%0A%20%20%20%20%20%20%20%20%22niveau%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%22code%22%3A%20%22NV2%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%22libelle%22%3A%20%22Bac%20%2B2%22%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%2C%0A%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%22diplomeObtenu%22%3A%20false%2C%0A%20%20%20%20%20%20%20%20%22etranger%22%3A%20true%2C%0A%20%20%20%20%20%20%20%20%22intitule%22%3A%20%22BAC%22%2C%0A%20%20%20%20%20%20%20%20%22niveau%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%22code%22%3A%20%22NV1%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%22libelle%22%3A%20%22Bac%20%2B5%22%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%2C%0A%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%22diplomeObtenu%22%3A%20true%2C%0A%20%20%20%20%20%20%20%20%22etranger%22%3A%20true%2C%0A%20%20%20%20%20%20%20%20%22intitule%22%3A%20%22BAC%22%2C%0A%20%20%20%20%20%20%20%20%22niveau%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%22code%22%3A%20%22NV4%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%22libelle%22%3A%20%22Bac%20%2B1%22%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%5D%2C%0A%20%20%22coord%22%3A%20%7B%0A%20%20%20%20%22adresse1%22%3A%20%22APPARTEMENT%2045%22%2C%0A%20%20%20%20%22adresse2%22%3A%20%22RESIDENCE%20DU%20SOLEIL%22%2C%0A%20%20%20%20%22adresse3%22%3A%20%22BATIMENT%20B%22%2C%0A%20%20%20%20%22adresse4%22%3A%20%2234%20ALLEE%20DU%206%20JUIN%22%2C%0A%20%20%20%20%22codePostal%22%3A%20%2244230%22%2C%0A%20%20%20%20%22codeINSEE%22%3A%20%2244190%22%2C%0A%20%20%20%20%22libelleCommune%22%3A%20%22ST%20SEBASTIEN%20SUR%20LOIRE%22%2C%0A%20%20%20%20%22codePays%22%3A%20%22FR%22%2C%0A%20%20%20%20%22libellePays%22%3A%20%22FRANCE%22%0A%20%20%7D%2C%0A%20%20%22alloc%22%3A%20%7B%0A%20%20%20%20%22beneficiairePrestationSolidarite%22%3A%20false%2C%0A%20%20%20%20%22beneficiaireAssuranceChomage%22%3A%20false%0A%20%20%7D%0A%7D
