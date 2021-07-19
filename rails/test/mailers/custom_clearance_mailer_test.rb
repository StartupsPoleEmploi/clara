require "test_helper"

class CustomClearanceMailerTest < ActionMailer::TestCase
  test "invite" do

    email =  CustomClearanceMailer.change_password('someone@target.com', 'a_magic_link')

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["someone@target.com"], email.to
    assert_equal "Modifiez votre mot de passe.", email.subject
  end
end
