class Progressbar < ViewObject

  def after_init(args)
  end

  def progressbar_width
    percentage = PercentageOfProgressbar.new.call(current_question)
    (percentage * 400).round
  end

  def current_question
    @context.request.path.split("_questions")[0][1..-1]
  end
end
