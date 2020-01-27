class PercentageOfProgressbar

 def call(the_question)
    p '- - - - - - - - - - - - - - the_question- - - - - - - - - - - - - - - -' 
    pp the_question
    p ''
    res = QuestionManager.new.getCurrentWeight(the_question)
    p '- - - - - - - - - - - - - - res- - - - - - - - - - - - - - - -' 
    pp res
    p ''
    res
 end
  
end
