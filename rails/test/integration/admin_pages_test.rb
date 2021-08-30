require 'test_helper'

class AdminPagesTest < ActionDispatch::IntegrationTest

  test "Start a broken link detection" do
    #given
    allow(DetectBrokenLinksJob).to receive(:perform_later)
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
    post session_url, params: { session: { email: user.email, password: user.password }}
    #when
    post admin_post_broken_path
    #then
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal({"status"=>"ok, tâche démarrée, durée 3 min. environ. Vous pouvez allez voir sous /sidekiq/scheduled."}, json_response)
  end

  test "List broken links" do
    #given
    allow_any_instance_of(DetectBrokenLinksJob).to receive(:perform_later)
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
    Broken.create(url: "https://example.com", new_url: "https://other.com", aids_slug: '["aid1", "aid2"]', code: 502)
    post session_url, params: { session: { email: user.email, password: user.password }}
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

end
