class ReadGaStatsService


  def number_of_sessions
    res = 0
    begin
      res = Stat.first.ga[0]["data"]["totals"][0]["values"][0].to_i
    rescue Exception => e
      res = 0
    end
    res
  end

  def actual_ga
    Stat.first.ga
  end


end
