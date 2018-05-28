require 'rails_helper'

describe ReadStatsService do
  

  describe "advisor_kpi" do
    it 'Must return correct values' do
      sut = ReadStatsService.new.advisor_kpi(nominal_hj_ad_values)
      expect(sut).to eq({:ordered_label=>
        ["0 minutes",
         "1 à 5 minutes",
         "11 à 15 minutes",
         "6 à 10 minutes",
         "+ de 15 minutes"],
       :ordered_serie=>[1, 1, 2, 1, 2],
       :minutes_won=>"10",
       :seconds_won=>"17"})
    end
  end

  def nominal_hj_ad_values
    [{"Number"=>"1",
    "User"=>"551c6f46",
    "Date Submitted"=>"2018-04-23 12:59:47",
    "Country"=>"France",
    "Device"=>"desktop",
    "Browser"=>"Chrome 65.0.3325",
    "OS"=>"Windows 7",
    "Chers collègues conseiller(è)s Pôle emploi, aidez-nous à améliorer Clara ! Combien de temps pensez-vous gagner ou avoir gagné en utilisant ce service aujourd'hui ?"=>
     "+ de 15 minutes",
    "A quelle fréquence utilisez-vous Clara ?"=>"1 à 2 fois par jour"},
   {"Number"=>"2",
    "User"=>"724d7859",
    "Date Submitted"=>"2018-04-23 13:07:04",
    "Country"=>"France",
    "Device"=>"desktop",
    "Browser"=>"Chrome 65.0.3325",
    "OS"=>"Windows 7",
    "Chers collègues conseiller(è)s Pôle emploi, aidez-nous à améliorer Clara ! Combien de temps pensez-vous gagner ou avoir gagné en utilisant ce service aujourd'hui ?"=>
     "6 à 10 minutes",
    "A quelle fréquence utilisez-vous Clara ?"=>"1 à 2 fois par jour"},
  {"Number"=>"8",
    "User"=>"9a3135ea",
    "Date Submitted"=>"2018-04-23 15:25:17",
    "Country"=>"France",
    "Device"=>"desktop",
    "Browser"=>"Chrome 65.0.3325",
    "OS"=>"Windows 7",
    "Chers collègues conseiller(è)s Pôle emploi, aidez-nous à améliorer Clara ! Combien de temps pensez-vous gagner ou avoir gagné en utilisant ce service aujourd'hui ?"=>
     "1 à 5 minutes",
    "A quelle fréquence utilisez-vous Clara ?"=>""},
  {"Number"=>"10",
    "User"=>"724d7859",
    "Date Submitted"=>"2018-04-24 08:26:43",
    "Country"=>"France",
    "Device"=>"desktop",
    "Browser"=>"Chrome 65.0.3325",
    "OS"=>"Windows 7",
    "Chers collègues conseiller(è)s Pôle emploi, aidez-nous à améliorer Clara ! Combien de temps pensez-vous gagner ou avoir gagné en utilisant ce service aujourd'hui ?"=>
     "11 à 15 minutes",
    "A quelle fréquence utilisez-vous Clara ?"=>""},   
  {"Number"=>"13",
    "User"=>"1a5fe8ca",
    "Date Submitted"=>"2018-04-24 10:20:38",
    "Country"=>"France",
    "Device"=>"desktop",
    "Browser"=>"Chrome 65.0.3325",
    "OS"=>"Windows 7",
    "Chers collègues conseiller(è)s Pôle emploi, aidez-nous à améliorer Clara ! Combien de temps pensez-vous gagner ou avoir gagné en utilisant ce service aujourd'hui ?"=>
     "0 minutes",
    "A quelle fréquence utilisez-vous Clara ?"=>""},
  {"Number"=>"15",
    "User"=>"551c6f46",
    "Date Submitted"=>"2018-04-24 11:16:57",
    "Country"=>"France",
    "Device"=>"desktop",
    "Browser"=>"Chrome 65.0.3325",
    "OS"=>"Windows 7",
    "Chers collègues conseiller(è)s Pôle emploi, aidez-nous à améliorer Clara ! Combien de temps pensez-vous gagner ou avoir gagné en utilisant ce service aujourd'hui ?"=>
     "11 à 15 minutes",
    "A quelle fréquence utilisez-vous Clara ?"=>""},
  {"Number"=>"22",
    "User"=>"00000000",
    "Date Submitted"=>"2018-04-25 08:53:54",
    "Country"=>"France",
    "Device"=>"desktop",
    "Browser"=>"Chrome 66.0.3359",
    "OS"=>"Windows 7",
    "Chers collègues conseiller(è)s Pôle emploi, aidez-nous à améliorer Clara ! Combien de temps pensez-vous gagner ou avoir gagné en utilisant ce service aujourd'hui ?"=>
     "+ de 15 minutes",
    "A quelle fréquence utilisez-vous Clara ?"=>"3 ou 4 fois par jour"}]
  end

end
