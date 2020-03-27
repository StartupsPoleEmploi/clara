class SendRecall

  def call
    if _time_to_send_email?
      UserMailer.with(contact: @contact, origin: @origin).contact_email.deliver_now            
    end
  end

  def _time_to_send_email?
    now = DateTime.now
    now.between?(DateTime.now.change(hour:7, min:30), DateTime.now.change(hour:8, min:30))    
  end

end
