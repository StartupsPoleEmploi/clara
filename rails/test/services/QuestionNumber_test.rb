require "test_helper"

class QuestionNumberTest < ActiveSupport::TestCase
  
  test '.value for question "inscription" is always 1' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(Asker.new)
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("inscription")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(1, res)
  end
  test '.value for question "category" is always 2' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(Asker.new)
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("category")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(2, res)
  end
end
