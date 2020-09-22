class SendRecallJob < ApplicationJob

  queue_as :default

  # Do something later
  def perform(recall_id, original_url)
    if Recall.find(recall_id)
      SendRecall.new.call(recall_id, _root_url_for(original_url))
    end
  end

  def _root_url_for(original_url)
    res = ""
    if original_url.is_a?(String) && original_url.count("/") >= 3
      res = original_url.split("//").last.split("/").first
    end
    res
  end

end
