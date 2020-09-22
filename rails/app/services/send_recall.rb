class SendRecall

  def call(recall_id, original_url)
    recall_to_be_sent = Recall.find(recall_id)
    if recall_to_be_sent
      aid = recall_to_be_sent.aid || Aid.new
      recall_to_be_sent.status = "sent"
      recall_to_be_sent.save
      RecallMailer.with(
        email_target: recall_to_be_sent.email,
        aid_name: aid.name,
        aid_link:  "#{_root_url_for(original_url)}/admin/aid_creation/new_aid_stage_1?modify=true&slug=#{aid.slug.to_s}",
        aid_status: aid.status,
      ).recall_email.deliver_now
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
