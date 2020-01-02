require 'test_helper'

class ReqTest < ActionDispatch::IntegrationTest

  test "GET new_age_question_path is authorized" do
    get new_age_question_path
    assert_response :ok  # 200, ok
  end    

  test "GET admin_root_path is not authorized" do
    get admin_root_path
    assert_response :found  # 302, redirected
  end

  test "GET admin_rule_path is not authorized" do
    get admin_rules_path
    assert_response :found  # 302, redirected
  end

  test "POST admin_rule_checks_path is not authorized" do
    post admin_rule_checks_path
    assert_response :found  # 302, redirected
  end
end
