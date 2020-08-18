require "test_helper"

class BuildCallbackHashTest < ActiveSupport::TestCase

  test ".perform calls ExpireCache" do
    #given
    filter = Filter.create!(name: "Se déplacer")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    aid = Aid.create!(name: "aaa", contract_type: contract, ordre_affichage: 3, filters: [filter])
    allow_any_instance_of(PeConnectExtraction).to receive(:call).and_return(extraction)
    session_h = {}
    params_h = {code: 'any'}
    #when
    res = BuildCallbackHash.new.call(session_h, params_h, 'anyhost.com')
    #then
    assert_equal({"given_name"=>"ROBERT"}, res[:meta])
    assert_equal( '44', res[:asker].v_age)
    assert_equal( '44190', res[:asker].v_location_citycode)
    assert_equal( 1, res[:filters].size)
    assert_equal( 'se-deplacer', res[:filters][0].slug)
  end

  def extraction
    {
      :info => {
                 "given_name" => "ROBERT",
                "family_name" => "MARCHAND",
                     "gender" => "male",
          "idIdentiteExterne" => "9bcb92d9-6a7b-464d-9b46-8c28af2b5af1",
                      "email" => "emploistoredev@gmail.com",
                        "sub" => "9bcb92d9-6a7b-464d-9b46-8c28af2b5af1",
                 "updated_at" => 1597733401
      },
      :statut => {
             "codeStatutIndividu" => "0",
          "libelleStatutIndividu" => "Non demandeur d’emploi"
      },
      :birth => {
             "codeCivilite" => nil,
          "libelleCivilite" => nil,
          "nomPatronymique" => nil,
               "nomMarital" => nil,
                   "prenom" => nil,
          "dateDeNaissance" => "1976-03-12T00:00:00+01:00"
      },
      :formation => [
          {
                   "anneeFin" => 2016,
                "description" => "c'était bien :)",
              "diplomeObtenu" => true,
                    "domaine" => {
                     "code" => "15066",
                  "libelle" => "Efficacité personnelle"
              },
                   "etranger" => false,
                   "intitule" => "product manager d'élite"
          }
      ],
      :coord => {
            "adresse1" => "APPARTEMENT 45",
            "adresse2" => "RESIDENCE DU SOLEIL",
            "adresse3" => "BATIMENT B",
            "adresse4" => "34 ALLEE DU 6 JUIN",
          "codePostal" => "44230",
           "codeINSEE" => "44190",
      "libelleCommune" => "ST SEBASTIEN SUR LOIRE",
            "codePays" => "FR",
         "libellePays" => "FRANCE"
      },
      :alloc => {
        "beneficiairePrestationSolidarite" => false,
            "beneficiaireAssuranceChomage" => false
      }
    }
  end

end
