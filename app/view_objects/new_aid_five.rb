class NewAidFive < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @aid = locals[:page].resource
    @filters_size = locals[:filters_size]
    @whodunnit = locals[:whodunnit]
    @aid_status = locals[:aid_status]
  end

  def action_displayed
    @aid_status == "Publiée" ? "Publier les modification" : "Continuer"
  end

  def reread_h
    res = {class: "c-newbutton c-newaid-actionrecord js-askforreread"}
    if !_all_stages_ok?
      res[:disabled] = "disabled"
    end
    res    
  end

  def big_message(current_user_email)
    if status_published?
      "Cette aide est actuellement en ligne."
    elsif status_archived?
      "L'aide a été archivée."
    elsif publishable?(current_user_email)
      "L'aide est prête à être publiée."
    elsif _all_stages_ok?
      "L'aide a toutes les informations requises."
    else
      "L'aide a été enregistrée en tant que brouillon."
    end
  end

  def publishable?(current_user_email)
    !status_published? && _all_stages_ok? && @whodunnit != current_user_email && status_waiting_for?
  end

  def status_correct?
    @aid_status == "Correct"
  end

  def status_published?
    @aid_status == "Publiée"
  end

  def status_waiting_for?
    @aid_status == "En attente de relecture"
  end

  def status_archived?
    @aid_status == "Archivée"
  end

  def _all_stages_ok?
    stage_1_ok? && stage_2_ok? && stage_3_ok? && stage_4_ok?
  end

  def small_message(current_user_email)
    if status_published?
      "Vous pouvez éventuellement l'archiver pour la retirer du site web."
    elsif status_archived? && _all_stages_ok?
      "Vous pouvez la publier, attention il n'y aura pas de relecture requise."
    elsif status_archived? && !_all_stages_ok?
      "Vous pourrez la publier à nouveau, une fois que les champs obligatoires auront été remplis."
    elsif publishable?(current_user_email)
      "Veuillez relire attentivement le contenu avant publication."
    elsif _all_stages_ok?
      "Elle sera publiée sur le site après relecture par un tiers."
    elsif @aid_status == "Brouillon" && @aid[:archived_at] == nil
      "Cette aide a déjà été publiée. Elle le sera à nouveau quand les champs obligatoires ci-dessous auront été renseignés."
    else
      "Vous pourrez demander une relecture pour publication une fois que toutes les informations obligatoires auront été renseignées."
    end
  end


  def stage_1_ok?
    true
  end

  def stage_1_comment
    "Toutes les <strong>informations obligatoires</strong> ont été <strong>saisies</strong>."
  end

  def stage_2_ok?
    _stage_2_missing_keys.empty?
  end

  def stage_2_comment
    if stage_2_ok?
      "Toutes les <strong>informations obligatoires</strong> (Comment faire la demande, Contenu de l'aide, Description) ont été <strong>saisies</strong>."
    else
      missing_parts = _stage_2_missing_keys.map { |e| stage_2_translation(e)  }.join("</strong>, <strong>")
      "Des parties <strong>obligatoires</strong> sont manquantes : <strong>#{missing_parts}</strong>."
    end
  end

  def stage_2_translation(key)
      {
        what: "Description",
        how_much: "Contenu de l'aide",
        how_and_when: "Comment faire la demande",
        additionnal_conditions: "Conditions à remplir",
        limitations: "Informations complémentaires"
      }[key]
  end

  def _stage_2_missing_keys
    [
      :how_and_when,
      :how_much,
      :what
    ].reduce([]) { |memo, k| memo.push(k) if @aid[k].blank?; memo}
  end

  def stage_3_ok?
    true
  end

  def stage_3_comment
    if @aid[:short_description] && @filters_size == 0
      "Le <strong>résumé</strong> a été renseigné, mais pas le/les filtre(s). Ces champs ne sont pas obligatoires."
    elsif !@aid[:short_description] && @filters_size > 0
      "Le/les <strong>filtres</strong> ont été renseignés, mais pas le résumé. Ces champs ne sont pas obligatoires."
    elsif @aid[:short_description] && @filters_size > 0
      "Le <strong>résumé</strong> et le/les <strong>filtre(s)</strong> ont été renseignés."
    elsif !@aid[:short_description] && @filters_size == 0
      "Ni le <strong>résumé</strong>, ni les <strong>filtres</strong> n'ont été renseignés, mais ils ne sont pas obligatoires."
    end
  end

  def stage_4_ok?
    !@aid[:rule_id].blank?
  end

  def stage_4_comment
    if stage_4_ok?
      "Le <strong>champ d'application</strong> a été <strong>correctement renseigné.</strong>"
    else
      "Le <strong>champ d'application</strong> n'a pas été renseigné, il est <strong>obligatoire.</strong>"
    end
  end

end
