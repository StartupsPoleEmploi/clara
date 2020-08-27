class FakeConnection
  
  def call(fake)
    public_send("fake_#{fake}")
  end

def fake_3
    {
         :info => {
            "given_name" => "Roger"
          },
       :statut => {
           "codeStatutIndividu" => "1",
        "libelleStatutIndividu" => "Demandeur d’emploi"
        },
        :birth => {
           "codeCivilite" => nil,
        "libelleCivilite" => nil,
        "nomPatronymique" => nil,
             "nomMarital" => nil,
                 "prenom" => 'Roger',
        "dateDeNaissance" => "1962-03-12T00:00:00+01:00"
      },
    :formation => [],
        :coord => {
              "adresse1" => "APPARTEMENT 22",
              "adresse2" => "RESIDENCE TRAVAIL",
              "adresse3" => "BATIMENT 1",
              "adresse4" => "6 rue jean moulin",
            "codePostal" => "58000",
             "codeINSEE" => "58194",
        "libelleCommune" => "NEVERS",
              "codePays" => "FR",
           "libellePays" => "FRANCE"
    },
        :alloc => {
        "beneficiairePrestationSolidarite" => true,
            "beneficiaireAssuranceChomage" => true
    }
  }
  end


  def fake_2
    {
         :info => {
            "given_name" => "Sandrine"
          },
       :statut => {
           "codeStatutIndividu" => "1",
        "libelleStatutIndividu" => "Demandeur d’emploi"
        },
        :birth => {
           "codeCivilite" => nil,
        "libelleCivilite" => nil,
        "nomPatronymique" => nil,
             "nomMarital" => nil,
                 "prenom" => 'Sandrine',
        "dateDeNaissance" => "1970-03-12T00:00:00+01:00"
      },
    :formation => [
        {
                 "anneeFin" => 2013,
              "description" => "Aprentissage de l'intégration et de la gestion des environnemnts",
            "diplomeObtenu" => true,
                  "domaine" => {
                   "code" => "31082",
                "libelle" => "Intégration informatique"
            },
        },
        {
            "diplomeObtenu" => false,
                 "etranger" => true,
                 "intitule" => "BAC",
                   "niveau" => {
                         "code" => "AFS",
                      "libelle" => "Aucune formation scolaire"
                    }
        },
        {
            "diplomeObtenu" => true,
                 "etranger" => true,
                 "intitule" => "BAC",
                   "niveau" => {
                     "code" => "NV2",
                  "libelle" => "Bac +2"
                  }
        },
        {
            "diplomeObtenu" => true,
                 "etranger" => true,
                 "intitule" => "BAC",
                   "niveau" => {
                     "code" => "NV4",
                  "libelle" => "Bac +1"
                  }
        }
    ],
        :coord => {
              "adresse1" => "APPARTEMENT 28",
              "adresse2" => "RESIDENCE TRAVAIL",
              "adresse3" => "BATIMENT 1",
              "adresse4" => "22 Rue Frédéric Peyson",
            "codePostal" => "34000",
             "codeINSEE" => "34172",
        "libelleCommune" => "MONTPELLIER",
              "codePays" => "FR",
           "libellePays" => "FRANCE"
    },
        :alloc => {
        "beneficiairePrestationSolidarite" => false,
            "beneficiaireAssuranceChomage" => false
    }
  }
  end

  def fake_1
    {
         :info => {
            "given_name" => "David"
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
        "dateDeNaissance" => "1982-03-12T00:00:00+01:00"
      },
    :formation => [
        {
                 "anneeFin" => 2013,
              "description" => "Aprentissage de l'intégration et de la gestion des environnemnts",
            "diplomeObtenu" => true,
                  "domaine" => {
                   "code" => "31082",
                "libelle" => "Intégration informatique"
            },
                 "etranger" => true,
                 "intitule" => "dîplome ingénieur",
                     "lieu" => "Afrique du Sud",
                   "niveau" => {
                   "code" => "NV3",
                "libelle" => "Bac"
            }
        },
        {
            "diplomeObtenu" => false,
                 "etranger" => true,
                 "intitule" => "BAC",
                   "niveau" => {
                   "code" => "AFS",
                "libelle" => "Aucune formation scolaire"
            }
        },
        {
            "diplomeObtenu" => true,
                 "etranger" => true,
                 "intitule" => "BAC",
                   "niveau" => {
                   "code" => "NV2",
                "libelle" => "Bac +2"
            }
        },
        {
            "diplomeObtenu" => false,
                 "etranger" => true,
                 "intitule" => "BAC",
                   "niveau" => {
                   "code" => "NV1",
                "libelle" => "Bac +5"
            }
        },
        {
            "diplomeObtenu" => true,
                 "etranger" => true,
                 "intitule" => "BAC",
                   "niveau" => {
                   "code" => "NV4",
                "libelle" => "Bac +1"
            }
        }
    ],
        :coord => {
              "adresse1" => "APPARTEMENT 45",
              "adresse2" => "RESIDENCE DU SOLEIL",
              "adresse3" => "BATIMENT B",
              "adresse4" => "34 ALLEE DU 6 JUIN",
            "codePostal" => "44230",
             "codeINSEE" => "44190",
        "libelleCommune" => "ST-SEBASTIEN-SUR-LOIRE",
              "codePays" => "FR",
           "libellePays" => "FRANCE"
    },
        :alloc => {
        "beneficiairePrestationSolidarite" => true,
            "beneficiaireAssuranceChomage" => false
    }
  }
  end

end
