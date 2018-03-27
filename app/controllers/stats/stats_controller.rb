module Stats
  class StatsController < ApplicationController

    def index
      render locals: {
        number_of_sessions: ga_stats.number_of_sessions
      }      
    end

  end
end
