require 'test_helper'

class HeaderHelperTest < ActionView::TestCase

  test ".display_disconnect_button? true if id_token is in session, and path is not peconnect_callback_path" do
    #given
    session = OpenStruct.new(id_token: 'filled')
    request = OpenStruct.new(path: 'any')
    #when
    res =  display_disconnect_button?(session, request)
    #then
    assert_equal true, res
  end

  test ".display_disconnect_button? false if id_token is in session, and path is peconnect_callback_path" do
    #given
    session = OpenStruct.new(id_token: 'filled')
    request = OpenStruct.new(path: peconnect_callback_path)
    #when
    res =  display_disconnect_button?(session, request)
    #then
    assert_equal false, res
  end

  test ".display_disconnect_button? false if id_token is in not session, and path is not peconnect_callback_path" do
    #given
    session = OpenStruct.new(id_token: nil)
    request = OpenStruct.new(path: 'any')
    #when
    res =  display_disconnect_button?(session, request)
    #then
    assert_equal false, res
  end

  test ".display_disconnect_button? false if id_token is in not session, and path is peconnect_callback_path" do
    #given
    session = OpenStruct.new(id_token: 'filled')
    request = OpenStruct.new(path: peconnect_callback_path)
    #when
    res =  display_disconnect_button?(session, request)
    #then
    assert_equal false, res
  end

end
