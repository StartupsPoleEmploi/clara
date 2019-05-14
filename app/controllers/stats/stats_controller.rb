module Stats
  class StatsController < ApplicationController

    def index
      redirect_to ENV["ARA_STATS"]
    end

  end
end
