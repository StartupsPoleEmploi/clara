class PeConnectExtraction

  def call(session, base_url, code, fake)
    res = {}
    
    if fake
      res = FakeConnection.new.call(fake)
      session[:id_token] = 'fake'
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

# https://dboureau.beta.pole-emploi.fr/peconnect_callback?fake=1
# https://dboureau.beta.pole-emploi.fr/peconnect_callback?fake=2
# https://dboureau.beta.pole-emploi.fr/peconnect_callback?fake=3
