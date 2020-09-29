class DetectBrokenLinksJob < ApplicationJob
  queue_as :default

  def perform(*args)
    DetectBrokenLinks.new.call
  end

end
