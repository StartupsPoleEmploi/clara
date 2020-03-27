class SendRecallJob < ApplicationJob

  queue_as :default

  # Do something later
  def perform(*args)
    is_forced = args[0]
    domain = args[1]
    protocol = args[2]
    SendRecall.new.call(is_forced, domain, protocol)
  end

end
