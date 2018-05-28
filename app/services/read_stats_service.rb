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
    JSON.parse(Stat.first.hj_ad)["json_data"]
    # [{"Number"=>"1", "User"=>"551c6f46", "Date Submitted"=>"2018-04-23 12:59:47", "Country"=>"France", "Device"=>"desktop", "Browser"=>"Chrome 65.0.3325", "OS"=>"Windows 7", "Chers coll\u00E8gues conseiller(\u00E8)s P\u00F4le emploi, aidez-nous \u00E0 am\u00E9liorer Clara ! Combien de temps pensez-vous gagner ou avoir gagn\u00E9 en utilisant ce service aujourd'hui ?"=> "+ de 15 minutes", "A quelle fr\u00E9quence utilisez-vous Clara ?"=>"1 \u00E0 2 fois par jour"}]
  end

  def advisor_all(json_data=advisor_savedtime_stats)
    time_only = json_data.map.with_index do |e, i|  
      res = {}
      res["id"] = e["Number"]
      time_val = e.detect{|key, value| key.downcase.include?('combien de temps') }[1]
      res["time"] = time_val
      res
    end
    # [{"id"=>"1", "time"=>"+ de 15 minutes"},{"id"=>"2", "time"=>"6 \u00E0 10 minutes"},{"id"=>"8", "time"=>"1 \u00E0 5 minutes"},{"id"=>"10", "time"=>"11 \u00E0 15 minutes"},{"id"=>"13", "time"=>"0 minutes"},{"id"=>"15", "time"=>"11 \u00E0 15 minutes"},{"id"=>"22", "time"=>"+ de 15 minutes"}]

    grouped_time = time_only.group_by{ |e| e["time"] }.transform_values { |x| x.size }
    # {"+ de 15 minutes"=>2,"6 \u00E0 10 minutes"=>1,"1 \u00E0 5 minutes"=>1,"11 \u00E0 15 minutes"=>2,"0 minutes"=>1}

    # ordered_label = grouped_time.keys.sort_by{ |e| e.split(" ")[0]}.rotate
    ordered_label = ["0 minutes", "1 à 5 minutes", "11 à 15 minutes", "6 à 10 minutes", "+ de 15 minutes"]
    # ["0 minutes","1 \u00E0 5 minutes","11 \u00E0 15 minutes","6 \u00E0 10 minutes","+ de 15 minutes"]

    raise "Error, keys do not match" unless grouped_time.keys.all? { |e| ordered_label.include?(e) } 

    ordered_serie = ordered_label.map { |e| grouped_time[e]}.map { |e| e.to_i  }

    time_won_serie = [0, 3*60, 8*60, 13*60, 20*60]

    weighted_serie = ordered_serie.map.with_index { |e, i| e * time_won_serie[i]}

    seconds_won_per_advisor = weighted_serie.sum / ordered_serie.sum

    time_won_per_advisor = Time.at(seconds_won_per_advisor).utc.strftime("%H:%M:%S")

    minutes_won = time_won_per_advisor.split(":")[1]
    seconds_won = time_won_per_advisor.split(":")[2]

    result = {
      ordered_label: ordered_label,
      ordered_serie: ordered_serie,
      minutes_won: minutes_won,
      seconds_won: seconds_won,
    }
    # p '- - - - - - - - - - - - - - if you need to debug - - - - - - - - - - - - - - - -' 
    # pp json_data
    # pp time_only
    # pp grouped_time
    # pp ordered_label
    # pp ordered_serie
    # pp time_won_serie
    # pp weighted_serie
    # pp seconds_won_per_advisor
    # pp time_won_per_advisor
    # pp result
    # p ''

    return result

  end


end

