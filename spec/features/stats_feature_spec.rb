require 'rails_helper'

feature 'Stats' do 

  before do
    create(:stat, 
              ga: JSON.parse('{
                "json_data": [
                  {
                    "Sessions": "12",
                    "Index des jours": "01/01/2018"
                  },
                  {
                    "Sessions": "249",
                    "Index des jours": "02/01/2018"
                  },
                  {
                    "Sessions": "1117",
                    "Index des jours": "02/08/2018"
                  }
                ]
              }'),
              hj_ad: JSON.parse('{
                  "json_data": [
                  {
                      "OS": "Windows 7",
                      "User": "551c6f46",
                      "Device": "desktop",
                      "Number": "1",
                      "Browser": "Chrome 65.0.3325",
                      "Country": "France",
                      "Date Submitted": "2018-04-23 12:59:47",
                      "A quelle fréquence utilisez-vous Clara ?": "1 à 2 fois par jour",
                      "Chers collègues conseiller(è)s Pôle emploi, aidez-nous à améliorer Clara ! Combien de temps pensez-vous gagner ou avoir gagné en utilisant ce service aujourd\'hui ?": "+ de 15 minutes"
                    },
                    {
                      "OS": "Windows 7",
                      "User": "724d7859",
                      "Device": "desktop",
                      "Number": "2",
                      "Browser": "Chrome 65.0.3325",
                      "Country": "France",
                      "Date Submitted": "2018-04-23 13:07:04",
                      "A quelle fréquence utilisez-vous Clara ?": "1 à 2 fois par jour",
                      "Chers collègues conseiller(è)s Pôle emploi, aidez-nous à améliorer Clara ! Combien de temps pensez-vous gagner ou avoir gagné en utilisant ce service aujourd\'hui ?": "+ de 15 minutes"
                    }
                  ]
              }')
          )
  end

  scenario 'Visit index' do 
    zzz = Stat.first
    p '- - - - - - - - - - - - - - zzz- - - - - - - - - - - - - - - -' 
    pp zzz
    p ''
    visit stats_index_path
  end

  # scenario 'Visit time' do 
  #   visit stats_index_path
  # end

end
