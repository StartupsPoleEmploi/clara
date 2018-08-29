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
              ga_pe: JSON.parse('{
                "json_data": [
                {
                    "Segment": "Tous les utilisateurs",
                    "Sessions": "12",
                    "Index des jours": "01/01/2018"
                  },
                  {
                    "Segment": "Conseillers PE",
                    "Sessions": "0",
                    "Index des jours": "01/01/2018"
                  },
                  {
                    "Segment": "Tous les utilisateurs",
                    "Sessions": "249",
                    "Index des jours": "02/01/2018"
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

  scenario 'Visit index, displays the total number of visitors' do 
    visit stats_index_path
    expect(find('.c-stats-totalview__number').text).to eq "1378"
  end

  scenario 'Visit time, display time spare per advisor' do 
    visit stats_time_path
    expect(find('.c-stats-savedtime__number').text).to eq "20 min 00 s"
  end

end
