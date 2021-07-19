require "test_helper"

class ListBrokenLinksTest < ActiveSupport::TestCase
  

  test '.call creates a rule from Town, UUID, and operator_kind' do
    #given
    faraday_stub = double("faraday_stub")
    allow(faraday_stub).to receive(:head).with('http://example.com').and_return(OpenStruct.new(status: 301, env: OpenStruct.new(response_headers: {'location' => 'http://new_location'})))
    allow_any_instance_of(ListAidLinks).to receive(:call).and_return([{aid_slug: 'mon-aide', links:['http://example.com']}])
    #when
    result = ListBrokenLinks.new.call(faraday_stub)
    #then
    assert_equal [{:url=>"http://example.com", :code=>301, :new_url=>"http://new_location", :aids_slug=>["mon-aide"]}], result
  end

end
