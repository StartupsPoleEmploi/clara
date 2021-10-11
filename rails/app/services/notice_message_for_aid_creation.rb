class NoticeMessageForAidCreation

  def call(step, aid_status)
    res = ''

    if step.in?(['step_2', 'step_3'])
      if aid_status == "Publiée"
        res = "Les modifications vont être publiées sur le site web ! <br> Cela peut prendre quelques secondes."
      else
        res = "Le contenu a été mis à jour"
      end
    end

    if step == 'step_4'
      if aid_status == "Publiée"
        res = "Les modifications vont être publiées sur le site web ! <br> Cela peut prendre quelques secondes."
      else
        res = "Mise à jour du champ d'application effectué."
      end
    end

    res    
  end
  
end
