class ReadGaStatsService


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


end
