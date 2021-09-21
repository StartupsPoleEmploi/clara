class CreateStage1

  def call(slug, new_attributes)
    result = 
    notice_msg = ""
    new_ordre_affichage = new_attributes[:ordre_affichage] || 99 
    new_attributes[:ordre_affichage] = new_ordre_affichage
    if !slug.blank?
      aid = Aid.find_by(slug: slug)
      aid.assign_attributes(new_attributes)
    else
      aid = Aid.new(new_attributes)
    end

    was_new = aid.id == nil

    is_successfully_saved = aid.save

    if is_successfully_saved
      # Hack to consider it as a "draft"
      if was_new
        aid.archived_at = aid.created_at
      end
      # end of hack
      aid.update_status;
      if slug.blank?
        notice_msg = "L'aide a bien été enregistrée en tant que brouillon."
      elsif aid.status != "Publiée"
        notice_msg = "Les modifications ont bien été enregistrées."
      elsif aid.status == "Publiée"
        notice_msg = "Les modifications vont être publiées sur le site web ! <br> Cela peut prendre quelques secondes."
      end
    end

    [is_successfully_saved, aid, notice_msg]
  end
  
end
