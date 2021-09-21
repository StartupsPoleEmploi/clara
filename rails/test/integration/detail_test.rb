require 'test_helper'

class DetailTest < ActionDispatch::IntegrationTest

  test "Detail : feedback submit" do
    #given
    nb_of_beedback_before = Feedback.count
    #when
    post feedback_path({params:{content: 'some text', positive: 'yes', url_of_detail: 'http://example.com'}})
    #then
    assert_response :success
    assert_equal nb_of_beedback_before + 1, Feedback.count
  end



end
