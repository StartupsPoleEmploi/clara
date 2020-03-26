class SendRecallJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    SendRecall.new.call
  end
end
