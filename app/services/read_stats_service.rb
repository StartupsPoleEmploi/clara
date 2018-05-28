class ReadStatsService

  def visitor_kpi
    res = 0
    begin
      res = Stat.first.ga[0]["data"]["totals"][0]["values"][0].to_i
    rescue Exception => e
      res = 0
    end
    res
  end

  def visitor_stats
    Stat.first.ga
  end

  def visitor_stats_pe
    Stat.first.ga_pe
  end

  def advisor_savedtime_stats
    Stat.first.hj_ad
  end

  def advisor_kpi(stub)
    # JSON.parse(Stat.first.hj_ad)
    json_data = stub
    time_only = json_data.map.with_index do |e, i|  
      res = {}
      res["id"] = e["Number"]
      time_val = e.detect{|key, value| key.downcase.include?('combien de temps') }[1]
      res["time"] = time_val
      res
    end
    p '- - - - - - - - - - - - - - time_only- - - - - - - - - - - - - - - -' 
    p time_only.inspect
    p ''
  end


end

ReadStatsService.new.advisor_kpi([{"Number"=>"1",
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
    "A quelle fréquence utilisez-vous Clara ?"=>"3 ou 4 fois par jour"}])
