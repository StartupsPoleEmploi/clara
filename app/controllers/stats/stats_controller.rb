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
        visitor_kpi: read_stats.visitor_kpi,
        visitor_stats: read_stats.visitor_stats,
        visitor_stats_pe: read_stats.visitor_stats_pe,
        savedtime_all: read_stats.advisor_all
      }
    end

    # GET /stats/time
    # GET /stats/time.json
    def time
      respond_to do |format|
        format.html { render locals: time_res }
        format.json { render json: time_res }
      end
    end
    def time_res
      {
        visitor_kpi: read_stats.visitor_kpi,
        savedtime_all: read_stats.advisor_all
      }
    end

  end
end
