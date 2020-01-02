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

  test "GET admin_root_path is authorized for contributeur" do
    contributeur = User.create!(role: "contributeur", email:"c@c.com", password: "p")
    get admin_root_path(as: contributeur)
    assert_response :ok  # 200
  end

  test "POST admin_rule_checks_path is not authorized" do
    post admin_rule_checks_path
    assert_response :found  # 302, redirected
  end

  test "POST admin_rule_checks_path is authorized for a superadmin" do
    superadmin = User.create!(role: "superadmin", email:"s@c.com", password: "p")
    # throws an exception instead of redirecting, it means that access is authorized...
    assert_raises Exception do
      post admin_rule_checks_path(as: superadmin)
    end
  end
end
