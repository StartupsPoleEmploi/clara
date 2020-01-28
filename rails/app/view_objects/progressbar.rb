class Progressbar < ViewObject

  def after_init(args)
  end

  def progressbar_width
    percentage = QuestionManager.new.getCurrentWeight(current_question)
    # Note that background is already 50% of contained with,
    # thus need here to divide percentage by 2.
    (percentage*100 / 2).round
  end

  def current_question
    @context.request.path.split("_questions")[0][1..-1]
  end
end
