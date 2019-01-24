class ExpireCacheJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    ExpireCache.call
  end
end
