require "test_helper"

class UrlExistsTest < ActiveSupport::TestCase
  
  test '.call(url_string) returns true if URL actually exists' do
    #given
    url_string = 'https://example.com/some_path'
    mocked_net_http = double
    allow(Net::HTTP).to receive(:new).and_return(mocked_net_http)

    expect(mocked_net_http).to receive(:use_ssl=).with(true)
    expect(mocked_net_http).to receive(:request_head).with('/some_path').and_return(OpenStruct.new(code: '200'))

    #when
    result = UrlExists.new.call(url_string)
    #then
    assert_equal(true, result)
  end

  test '.call(url_string) returns true, even for unsecured endpoint (http, not https)' do
    #given
    url_string = 'http://example.com/some_path'
    mocked_net_http = double
    allow(Net::HTTP).to receive(:new).and_return(mocked_net_http)

    expect(mocked_net_http).to receive(:use_ssl=).with(false)
    expect(mocked_net_http).to receive(:request_head).with('/some_path').and_return(OpenStruct.new(code: '200'))

    #when
    result = UrlExists.new.call(url_string)
    #then
    assert_equal(true, result)
  end

  test '.call(url_string) returns false if URL returns a 4xx code' do
    #given
    url_string = 'https://example.com/some_path'
    mocked_net_http = double
    allow(Net::HTTP).to receive(:new).and_return(mocked_net_http)

    expect(mocked_net_http).to receive(:use_ssl=).with(true)
    expect(mocked_net_http).to receive(:request_head).with('/some_path').and_return(OpenStruct.new(code: '404'))

    #when
    result = UrlExists.new.call(url_string)
    #then
    assert_equal(false, result)
  end

  test '.call(url_string) returns false if URL returns a 5xx code' do
    #given
    url_string = 'https://example.com/some_path'
    mocked_net_http = double
    allow(Net::HTTP).to receive(:new).and_return(mocked_net_http)

    expect(mocked_net_http).to receive(:use_ssl=).with(true)
    expect(mocked_net_http).to receive(:request_head).with('/some_path').and_return(OpenStruct.new(code: '503'))

    #when
    result = UrlExists.new.call(url_string)
    #then
    assert_equal(false, result)
  end

  test '.call(url_string) follow redirection if needed' do
    #given
    url_string = 'https://example.com/some_path'
    mocked_net_http = double
    mocked_http_redirection = instance_double(Net::HTTPRedirection)
    allow(Net::HTTP).to receive(:new).and_return(mocked_net_http)

    expect(mocked_net_http).to receive(:use_ssl=).with(true)
    expect(mocked_net_http).to receive(:request_head).with('/some_path').and_return(mocked_http_redirection)
    expect(mocked_http_redirection).to receive(:code).and_return('200')

    #when
    result = UrlExists.new.call(url_string)
    #then
    assert_equal(true, result)
  end

  test '.call(url_string) returns false if Errno::ENOENT is raised' do
    #given
    url_string = 'https://example.com/some_path'
    mocked_net_http = double
    allow(Net::HTTP).to receive(:new).and_return(mocked_net_http)

    expect(mocked_net_http).to receive(:use_ssl=).with(true)
    expect(mocked_net_http).to receive(:request_head).with('/some_path').and_raise(Errno::ENOENT)

    #when
    result = UrlExists.new.call(url_string)
    #then
    assert_equal(false, result)
  end

  test '.call(url_string) returns false if URI::InvalidURIError is raised' do
    #given
    url_string = 'https://example.com/some_path'
    mocked_net_http = double
    allow(Net::HTTP).to receive(:new).and_return(mocked_net_http)

    expect(mocked_net_http).to receive(:use_ssl=).with(true)
    expect(mocked_net_http).to receive(:request_head).with('/some_path').and_raise(URI::InvalidURIError)

    #when
    result = UrlExists.new.call(url_string)
    #then
    assert_equal(false, result)
  end

  test '.call(url_string) returns false if SocketError is raised' do
    #given
    url_string = 'https://example.com/some_path'
    mocked_net_http = double
    allow(Net::HTTP).to receive(:new).and_return(mocked_net_http)

    expect(mocked_net_http).to receive(:use_ssl=).with(true)
    expect(mocked_net_http).to receive(:request_head).with('/some_path').and_raise(SocketError)

    #when
    result = UrlExists.new.call(url_string)
    #then
    assert_equal(false, result)
  end

  test '.call(url_string) returns false if Errno::ECONNREFUSED is raised' do
    #given
    url_string = 'https://example.com/some_path'
    mocked_net_http = double
    allow(Net::HTTP).to receive(:new).and_return(mocked_net_http)

    expect(mocked_net_http).to receive(:use_ssl=).with(true)
    expect(mocked_net_http).to receive(:request_head).with('/some_path').and_raise(Errno::ECONNREFUSED)

    #when
    result = UrlExists.new.call(url_string)
    #then
    assert_equal(false, result)
  end

  test '.call(url_string) returns false if Net::OpenTimeout is raised' do
    #given
    url_string = 'https://example.com/some_path'
    mocked_net_http = double
    allow(Net::HTTP).to receive(:new).and_return(mocked_net_http)

    expect(mocked_net_http).to receive(:use_ssl=).with(true)
    expect(mocked_net_http).to receive(:request_head).with('/some_path').and_raise(Net::OpenTimeout)

    #when
    result = UrlExists.new.call(url_string)
    #then
    assert_equal(false, result)
  end

  test '.call(url_string) returns false if OpenSSL::SSL::SSLError is raised' do
    #given
    url_string = 'https://example.com/some_path'
    mocked_net_http = double
    allow(Net::HTTP).to receive(:new).and_return(mocked_net_http)

    expect(mocked_net_http).to receive(:use_ssl=).with(true)
    expect(mocked_net_http).to receive(:request_head).with('/some_path').and_raise(OpenSSL::SSL::SSLError )

    #when
    result = UrlExists.new.call(url_string)
    #then
    assert_equal(false, result)
  end

end
