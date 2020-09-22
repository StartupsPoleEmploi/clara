class SendRecallJob < ApplicationJob

  queue_as :default

  def perform(recall_id, original_url)
    SendRecall.new.call(recall_id, original_url)
  end

end
