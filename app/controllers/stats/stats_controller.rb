module Stats
  class StatsController < ApplicationController


    # GET /stats
    # GET /stats.json
    def index
      respond_to do |format|
        format.html { render locals: index_res }
        format.json { render json: index_res }
      end
    end
    def index_res
      {
        visitor_kpi: read_ga_stats.visitor_kpi,
        visitor_stats: read_ga_stats.visitor_stats,
        visitor_stats_pe: read_ga_stats.visitor_stats_pe,
        savedtime_kpi: 'N/A',
        satisfaction_kpi: 'N/A',
      }
    end

  end
end
