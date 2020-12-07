class AnswerActivation
    
  def switch_value
    if get_value
      Offanswer.first.update_attribute(:value, 'off')
    else
      Offanswer.first.update_attribute(:value, 'on')
    end
  end

  def get_value
    unless Offanswer.first
      Offanswer.new.save
    end
    Offanswer.first.value != 'off'
  end
end
