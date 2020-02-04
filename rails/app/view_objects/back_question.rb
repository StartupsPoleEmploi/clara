class BackQuestion < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @back_to_previous = string_for(locals[:back_to_previous])
  end

  def _get_asker
    Asker.new(JSON.parse(@context.session[:asker].to_s))
  end  

  def _current_question
    @context.request.path.split("_questions")[0][1..-1]
  end

  def url
    QuestionManager.new.public_send('before_' + _current_question, _get_asker)
  end

  def onclick_value
    res = "window.location.href='#{url}'"
    if @back_to_previous == "yes"
      res = "window.history.back()"
    end
    res
  end

  def actual_text
    res = "Retour à la question précédente"
    if @back_to_previous == "yes"
      res = "Retour à la page précédente"
    end
    res
  end

end
