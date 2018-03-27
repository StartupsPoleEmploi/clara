class GaStatsService


  def number_of_sessions
    res = 0
    begin
      res = Stats.first.ga[0]["data"]["totals"][0]["values"][0].to_i
    rescue Exception => e
      res = 0
    end
    res
  end


end
