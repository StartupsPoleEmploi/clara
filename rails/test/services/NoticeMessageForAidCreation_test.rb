require "test_helper"
    
class NoticeMessageForAidCreationTest < ActiveSupport::TestCase

  test ".call, with empty args, returns String" do
    #given
    step  = nil
    aid_status  = nil
    #when
    res = NoticeMessageForAidCreation.new.call(step, aid_status)
    #then
    assert_equal('', res)
  end

  test ".call, step_2, published" do
    #given
    step  = 'step_2'
    aid_status  = 'Publiée'
    #when
    res = NoticeMessageForAidCreation.new.call(step, aid_status)
    #then
    assert_equal(_message_ok, res)
  end
  test ".call, step_3, published" do
    #given
    step  = 'step_3'
    aid_status  = 'Publiée'
    #when
    res = NoticeMessageForAidCreation.new.call(step, aid_status)
    #then
    assert_equal(_message_ok, res)
  end
  test ".call, step_4, published" do
    #given
    step  = 'step_4'
    aid_status  = 'Publiée'
    #when
    res = NoticeMessageForAidCreation.new.call(step, aid_status)
    #then
    assert_equal(_message_ok, res)
  end

  test ".call, step_2, status is other than Publiee" do
    #given
    step  = 'step_2'
    aid_status  = 'Other'
    #when
    res = NoticeMessageForAidCreation.new.call(step, aid_status)
    #then
    assert_equal(_content_ok, res)
  end
  test ".call, step_3, status is other than Publiee" do
    #given
    step  = 'step_3'
    aid_status  = 'Other'
    #when
    res = NoticeMessageForAidCreation.new.call(step, aid_status)
    #then
    assert_equal(_content_ok, res)
  end
  test ".call, step_4, status is other than Publiee" do
    #given
    step  = 'step_4'
    aid_status  = 'Other'
    #when
    res = NoticeMessageForAidCreation.new.call(step, aid_status)
    #then
    assert_equal(_field_ok, res)
  end

  def _message_ok
    "Les modifications vont être publiées sur le site web ! <br> Cela peut prendre quelques secondes."
  end
  def _content_ok
    "Le contenu a été mis à jour"
  end
  def _field_ok
    "Mise à jour du champ d'application effectué."
  end

end

