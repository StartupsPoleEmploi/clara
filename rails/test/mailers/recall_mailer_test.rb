require "test_helper"

class RecallMailerTest < ActionMailer::TestCase
  test "invite" do

    email =  RecallMailer.with(
        email_target: 'someone@target.com',
        aid_name: 'name',
        aid_link:  'link',
        aid_status: 'status',
      ).recall_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["someone@target.com"], email.to
    assert_equal "[Clara] Vous avez une aide à vérifier !", email.subject
  end
end
