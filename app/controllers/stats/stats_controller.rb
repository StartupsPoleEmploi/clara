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
        number_of_sessions: ga_stats.number_of_sessions
      }
    end

  end
end
