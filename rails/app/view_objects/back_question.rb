class BackQuestion < ViewObject

  def after_init(args)
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

end
