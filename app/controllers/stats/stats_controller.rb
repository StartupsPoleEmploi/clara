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
        number_of_sessions: read_ga_stats.actual_ga,
        conversion: 'N/A',
        satisfaction: 'N/A'
      }
    end

  end
end
