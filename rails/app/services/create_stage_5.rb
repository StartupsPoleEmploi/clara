class CreateStage5

  def call(slug, action_asked)
    notice_message = ""

    aid = Aid.find_by(slug: slug)
    please_save_aid = true

    if action_asked == "archive"
      aid.archived_at = DateTime.now
      notice_message = "L'aide a bien été archivée, elle n'apparaîtra plus sur le site d'ici quelques secondes."
    elsif action_asked == "publish"
      aid.archived_at = nil
      notice_message = "<strong>L'aide va être publiée sur le site web ! </strong><br> Cela peut prendre quelques secondes..."
    elsif action_asked == "reread"
      aid.is_rereadable = true
      notice_message = "L'aide a été demandée pour relecture."
    elsif action_asked == "keep"
      notice_message = "L'aide a été conservée en tant que brouillon."
    elsif action_asked == "discard"
      please_save_aid = false
      notice_message = "Le brouillon a été supprimé."
    end

    if please_save_aid
      aid.save
      aid.update_status
    else
      aid.destroy
    end    

    notice_message
  end
  
end
