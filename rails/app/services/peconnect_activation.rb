class PeconnectActivation
    
  def switch_value
    off = Offpeconnect.first
    current_value = off.value.to_s
    off.value = "on" if current_value == "off"
    off.value = "off" if current_value == "on"
    off.save
  end

  def get_value
    unless Offpeconnect.first
      Offpeconnect.new.save
    end
    Offpeconnect.first.value != 'off'
  end
end
