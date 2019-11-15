class NewAidFive < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @aid = locals[:page].resource
    @filters_size = locals[:filters_size]
  end

  def stage_1_ok?
    true
  end

  def stage_1_comment
    "Toutes les <strong>informations obligatoires</strong> ont été <strong>saisies</strong>"
  end

  def stage_2_ok?
    _stage_2_missing_keys.empty?
  end

  def stage_2_comment
    if stage_2_ok?
      "Toutes les <strong>informations obligatoires</strong> ont été <strong>saisies</strong>"
    else
      missing_parts = _stage_2_missing_keys.map { |e| stage_2_translation(e)  }.join("</strong>, <strong>")
      "Des parties <strong>obligatoires</strong> sont manquantes : <strong>#{missing_parts}</strong>"
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
    [:additionnal_conditions,
    :how_and_when,
    :how_much,
    :limitations,
    :what].reduce([]) { |memo, k| memo.push(k) if @aid[k].blank?; memo}
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
    false
  end

end
