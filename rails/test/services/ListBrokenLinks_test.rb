require "test_helper"

class ListBrokenLinksTest < ActiveSupport::TestCase
  

  test '.call is able to detect and track a redirection' do
    #given
    faraday_stub = double("faraday_stub")
    allow(faraday_stub).to receive(:head).with('http://example.com').and_return(OpenStruct.new(status: 301, env: OpenStruct.new(response_headers: {'location' => 'http://new_location'})))
    allow_any_instance_of(ListAidLinks).to receive(:call).and_return([{aid_slug: 'mon-aide', links:['http://example.com']}])
    #when
    result = ListBrokenLinks.new.call(faraday_stub)
    #then
    assert_equal [{:url=>"http://example.com", :code=>301, :new_url=>"http://new_location", :aids_slug=>["mon-aide"]}], result
  end

  test '.call is able to handle a 200 (success) response' do
    #given
    faraday_stub = double("faraday_stub")
    allow(faraday_stub).to receive(:head).with('http://example.com').and_return(OpenStruct.new(status: 200))
    allow_any_instance_of(ListAidLinks).to receive(:call).and_return([{aid_slug: 'mon-aide', links:['http://example.com']}])
    #when
    result = ListBrokenLinks.new.call(faraday_stub)
    #then
    assert_equal [], result
  end

  test '.call may raise an error' do
    #given
    faraday_stub = double("faraday_stub")
    allow_any_instance_of(ListAidLinks).to receive(:call).and_return([{aid_slug: 'mon-aide', links:['http://example.com']}])
    allow(faraday_stub).to receive(:head).with('http://example.com').and_raise(ZeroDivisionError)
    #when
    result = ListBrokenLinks.new.call(faraday_stub)
    #then
    assert_equal([{:url=>"http://example.com", :code=>520, :aids_slug=>["mon-aide"]}], result)
  end

  test '.call may time out' do
    #given
    faraday_stub = double("faraday_stub")
    allow_any_instance_of(ListAidLinks).to receive(:call).and_return([{aid_slug: 'mon-aide', links:['http://example.com']}])
    allow(faraday_stub).to receive(:head).with('http://example.com').and_raise(Timeout::Error)
    #when
    result = ListBrokenLinks.new.call(faraday_stub)
    #then
    assert_equal([{:url=>"http://example.com", :code=>408, :aids_slug=>["mon-aide"]}], result)
  end

end
