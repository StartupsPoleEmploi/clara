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

# %7B%22info%22%3A%7B%22given_name%22%3A%22ROBERT%22%2C%22family_name%22%3A%22MARCHAND%22%2C%22gender%22%3A%22male%22%2C%22idIdentiteExterne%22%3A%229bcb92d9-6a7b-464d-9b46-8c28af2b5af1%22%2C%22email%22%3A%22emploistoredev%40gmail.com%22%2C%22sub%22%3A%229bcb92d9-6a7b-464d-9b46-8c28af2b5af1%22%2C%22updated_at%22%3A0%7D%2C%22statut%22%3A%7B%22codeStatutIndividu%22%3A%220%22%2C%22libelleStatutIndividu%22%3A%22Non%20demandeur%20d%E2%80%99emploi%22%7D%2C%22birth%22%3A%7B%22codeCivilite%22%3Anull%2C%22libelleCivilite%22%3Anull%2C%22nomPatronymique%22%3Anull%2C%22nomMarital%22%3Anull%2C%22prenom%22%3Anull%2C%22dateDeNaissance%22%3A%221976-03-12T00%3A00%3A00%2B01%3A00%22%7D%2C%22formation%22%3A%5B%7B%22anneeFin%22%3A2016%2C%22description%22%3A%22c%27%C3%A9tait%20bien%20%3A)%22%2C%22diplomeObtenu%22%3Atrue%2C%22domaine%22%3A%7B%22code%22%3A%2215066%22%2C%22libelle%22%3A%22Efficacit%C3%A9%20personnelle%22%7D%2C%22etranger%22%3Afalse%2C%22intitule%22%3A%22product%20manager%20d%27%C3%A9lite%22%7D%5D%2C%22coord%22%3A%7B%22adresse1%22%3A%22APPARTEMENT%2045%22%2C%22adresse2%22%3A%22RESIDENCE%20DU%20SOLEIL%22%2C%22adresse3%22%3A%22BATIMENT%20B%22%2C%22adresse4%22%3A%2234%20ALLEE%20DU%206%20JUIN%22%2C%22codePostal%22%3A%2244230%22%2C%22codeINSEE%22%3A%2244190%22%2C%22libelleCommune%22%3A%22ST%20SEBASTIEN%20SUR%20LOIRE%22%2C%22codePays%22%3A%22FR%22%2C%22libellePays%22%3A%22FRANCE%22%7D%2C%22alloc%22%3A%7B%22beneficiairePrestationSolidarite%22%3Afalse%2C%22beneficiaireAssuranceChomage%22%3Afalse%7D%7D
