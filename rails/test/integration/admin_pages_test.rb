require 'test_helper'

class AdminPagesTest < ActionDispatch::IntegrationTest

  test "Start a broken link detection" do
    #given
    allow(DetectBrokenLinksJob).to receive(:perform_later)
    connect_as_superadmin
    #when
    post admin_post_broken_path
    #then
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal({"status"=>"ok, tâche démarrée, durée 3 min. environ. Vous pouvez allez voir sous /sidekiq/scheduled."}, json_response)
  end

  test "List broken links" do
    #given
    Broken.create(url: "https://example.com", new_url: "https://other.com", aids_slug: '["aid1", "aid2"]', code: 502)
    connect_as_superadmin
    #when
    get admin_get_relink_path
    #then
    assert_response :success
    assert_equal '502', text_of('.c-relink-code-0').strip
    assert_equal 'https://example.com', text_of('.c-relink-url-0').strip
    assert_equal 'https://other.com', text_of('.c-relink-newurl-0').strip
    assert_equal '/admin/aids/aid1', text_of('.c-relink-slug-0-0').strip
    assert_equal '/admin/aids/aid2', text_of('.c-relink-slug-0-1').strip
  end

  test "Record answers, see the status" do
    #given
    connect_as_superadmin
    #when
    get admin_get_switch_answer_path
    #then
    assert_response :success
    assert_equal "L'enregistrement des réponses est actuellement désactivé", text_of('.c-get-switch-answer-text').strip
  end

  test "Record answers, set the status" do
    #given
    connect_as_superadmin
    #when
    post admin_post_switch_answer_path
    #then
    assert_redirected_to admin_get_switch_answer_path + '?locale=fr'
    #when
    get admin_get_switch_answer_path
    #then
    assert_equal "L'enregistrement des réponses est actuellement activé", text_of('.c-get-switch-answer-text').strip
  end

  test "Reinit password for existing user" do
    #given
    connect_as_superadmin
    superadmin = User.last
    #when
    post admin_post_resetpwd_path({email: 'superadmin@clara.com', new_pwd: 'FooBar99+'})
    #then
    assert_response :success
    json_response = JSON.parse(response.body)
    modified_superadmin = User.find(superadmin.id)
    assert_equal({"status"=>"ok"}, json_response)
    assert_not_equal(superadmin.encrypted_password, modified_superadmin.encrypted_password)
  end

  test "Destroy all existing answers" do
    #given
    connect_as_superadmin
    Answer.new.tap(&:save!)
    Answer.new.tap(&:save!)
    assert_equal(2,  Answer.count)
    #when
    post admin_post_reset_answers_path
    #then
    assert_response :success
    assert_equal(0,  Answer.count)
  end

end
