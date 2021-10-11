require 'test_helper'

class ResetSessionsTest < ActionDispatch::IntegrationTest

  test "reset sessions" do
    #given
    connect_as_superadmin
    expect(ActiveRecord::SessionStore::Session).to receive(:count).and_return(42)
    expect(Mae::Application).to receive(:load_tasks)
    expect(Rake::Task).to receive(:[]).with('db:sessions:clear').and_return(OpenStruct.new(invoke: 'any'))
    #when
    post admin_post_session_path
    #then
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal({"status"=>"ok", "count"=>42}, json_response)
  end

end
