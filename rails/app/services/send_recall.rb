class SendRecall

  def call(is_forced, root_url)
    p '- - - - - - - - - - - - - - is_forced- - - - - - - - - - - - - - - -' 
    pp is_forced
    p ''
    p '- - - - - - - - - - - - - - root_url- - - - - - - - - - - - - - - -' 
    pp root_url
    p ''
    p '- - - - - - - - - - - - - - _time_to_send_email?- - - - - - - - - - - - - - - -' 
    pp _time_to_send_email?
    p ''
    if _time_to_send_email? || is_forced
      recall_to_be_sent = Recall.please_send.first
      p '- - - - - - - - - - - - - - recall_to_be_sent- - - - - - - - - - - - - - - -' 
      ap recall_to_be_sent
      ap recall_to_be_sent.aid if recall_to_be_sent
      p ''
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
    now.between?(DateTime.now.change(hour:7, min:15), DateTime.now.change(hour:8, min:30))    
  end

end
