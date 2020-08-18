class PeconnectActivation
    
  def switch_value
    if get_value
      Offpeconnect.first.update_attribute(:value, 'off')
    else
      Offpeconnect.first.update_attribute(:value, 'on')
    end
  end

  def get_value
    unless Offpeconnect.first
      Offpeconnect.new.save
    end
    Offpeconnect.first.value != 'off'
  end
end
