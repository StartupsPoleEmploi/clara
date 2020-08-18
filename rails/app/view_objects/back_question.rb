class BackQuestion < ViewObject

  def after_init(args)
    locals = hash_for(args)
  end

  def _get_asker
    RequireAsker.new.call(@context.session)
  end  

  def _current_question
    @context.request.path.split("_questions")[0][1..-1]
  end

  def url
    res = QuestionManager.new.public_send('before_' + _current_question, _get_asker)
    if _current_question == "inscription"
      res = root_path
    end
    res
  end

  def onclick_value
    "window.location.href='#{url}'"
  end

  def actual_text
    res = "Retour à la question précédente"
    if _current_question == "inscription"
      res = "Retour à l'accueil"
    end
    res
  end

end
