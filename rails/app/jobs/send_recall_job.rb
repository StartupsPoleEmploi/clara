class SendRecallJob < ApplicationJob

  queue_as :default

  # Do something later
  def perform(*args)
    SendRecall.new.call(args[0])
  end

end
