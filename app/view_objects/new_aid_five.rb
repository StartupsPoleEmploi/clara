class NewAidFive < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @aid = locals[:page].resource
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
      "blabla"
    end
  end

  def stage_2_translation
      {
        what: "Description",
        how_much: "Contenu de l'aide",
        how_and_when: "Comment faire la demande ?",
        additionnal_conditions: "Conditions à remplir",
        limitations: "Informations complémentaires"
      }
  end

  def _number_of_stage_2_missing
    [ @aid[:additionnal_conditions].blank?,
      @aid[:how_and_when].blank?,
      @aid[:how_much].blank?,
      @aid[:limitations].blank?,
      @aid[:what].blank?].count{|e| e }
  end

  def _stage_2_missing_keys
    [:additionnal_conditions,
    :how_and_when,
    :how_much,
    :limitations,
    :what].reduce([]) { |memo, k| memo.push(k) if @aid[k].blank?; memo}
  end

  def stage_3_ok?
    false
  end

  def stage_4_ok?
    false
  end

end
