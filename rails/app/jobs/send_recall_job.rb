class SendRecallJob < ApplicationJob

  queue_as :default

  # Do something later
  def perform(*args)
    is_forced = args[0]
    original_url = args[1]
    SendRecall.new.call(is_forced, _root_url_for(original_url))
  end

  def _root_url_for(original_url)
    res = ""
    if original_url.is_a?(String) && original_url.count("/") >= 3
      res = original_url.split("//").last.split("/").first
    end
    res
  end

end
