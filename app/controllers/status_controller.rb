class StatusController < ApplicationController

  def index
    puma_instance = ObjectSpace.each_object(Puma::Launcher).first
    @status = {}
    @status[:db_stats] = ActiveRecord::Base.connection_pool.stat
    @status[:puma_stats] = JSON.parse(puma_instance.stats).merge(
        min_threads: puma_instance.options[:min_threads],
        max_threads: puma_instance.options[:max_threads]
    )
    @status[:version] = ARA_VERSION
    render layout: false
  end

end
