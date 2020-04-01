class SendRecall

  def call(is_forced, root_url)
    if _time_to_send_email? || is_forced
      recall_to_be_sent = Recall.please_send.first
      if recall_to_be_sent
        aid = recall_to_be_sent.aid || Aid.new
        recall_to_be_sent.status = "sent"
        recall_to_be_sent.save
        RecallMailer.with(
          email_target: recall_to_be_sent.email,
          aid_name: aid.name,
          aid_link: root_url + "/admin/aid_creation/new_aid_stage_1?modify=true&slug=" + aid.slug.to_s,
          aid_status: aid.status,
        ).recall_email.deliver_now
      end
    end
  end

  def _time_to_send_email?
    now = DateTime.now
    delta = Clockdiff.first.value
    now.between?(DateTime.now.change(hour: 7+delta, min: 15), DateTime.now.change(hour: 8+delta, min: 30))    
  end

end
