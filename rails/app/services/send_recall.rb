class SendRecall

  def call(is_forced)
    p '- - - - - - - - - - - - - - is_forced- - - - - - - - - - - - - - - -' 
    pp is_forced
    p ''
    p '- - - - - - - - - - - - - - _time_to_send_email?- - - - - - - - - - - - - - - -' 
    pp _time_to_send_email?
    p ''
    if _time_to_send_email? || is_forced
      recall_to_be_sent = Recall.please_send.first
      if recall_to_be_sent
        RecallMailer.with(email_target: recall_to_be_sent.email).contact_email.deliver_now            
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
