require "test_helper"

class RoutesListTest < ActiveSupport::TestCase

  test ".questions returns list of questions" do
    #given
    #when
    res = RoutesList.new.asked_questions
    #then
    assert_equal true, res.is_a?(Hash)
    assert_equal true, res.size > 2
    assert_equal res["new_age_question_path"], "/age_questions/new"
  end

end
