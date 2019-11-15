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
    _number_of_stage_2_missing == 0
  end

  def stage_2_comment
    if stage_2_ok?
      "Toutes les <strong>informations obligatoires</strong> ont été <strong>saisies</strong>"
    else
      "Les parties suivantes <strong>sont manquantes : </strong>"
    end
  end

  def _number_of_stage_2_missing
    [ @aid[:additionnal_conditions].blank?,
      @aid[:how_and_when].blank?,
      @aid[:how_much].blank?,
      @aid[:limitations].blank?,
      @aid[:what].blank?].count{|e| e }
  end

  def stage_3_ok?
    false
  end

  def stage_4_ok?
    false
  end

end
