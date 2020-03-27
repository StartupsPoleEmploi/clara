class SendRecall

  def call(is_forced, domain, protocol)
    p '- - - - - - - - - - - - - - is_forced- - - - - - - - - - - - - - - -' 
    pp is_forced
    p ''
    p '- - - - - - - - - - - - - - domain- - - - - - - - - - - - - - - -' 
    pp domain
    p ''
    p '- - - - - - - - - - - - - - protocol- - - - - - - - - - - - - - - -' 
    pp protocol
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
        RecallMailer.with(
          email_target: recall_to_be_sent.email,
          domain: domain,
          aid_name: aid.name,
          aid_link: protocol + domain + "/admin/aid_creation/new_aid_stage_1?locale=fr&modify=true&slug=" + aid.slug.to_s,
          aid_status: aid.status,
        ).recall_email.deliver_now
        recall_to_be_sent.status = "sent"
        recall_to_be_sent.save
      end
    end
  end

  def _time_to_send_email?
    now = DateTime.now
    now.between?(DateTime.now.change(hour:7, min:30), DateTime.now.change(hour:8, min:30))    
  end

end
