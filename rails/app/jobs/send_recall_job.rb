class SendRecallJob < ApplicationJob

  queue_as :default

  # Do something later
  def perform(*args)
    is_forced = args[0]
    domain = args[1]
    SendRecall.new.call(is_forced, domain)
  end

end
