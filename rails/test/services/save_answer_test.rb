require "test_helper"

class SaveAnswerTest < ActiveSupport::TestCase

    test 'By default, saves an asker an modify session' do
      #given
      session = {}
      asker = Asker.new({v_age: '42'})
      before_answer_count = Answer.count
      #when
      res = SaveAnswer.new.call(asker, session)
      #then
      after_answer_count = Answer.count
      assert_equal before_answer_count + 1, after_answer_count
      assert_equal session[:saved_answer], 'true'
    end

    test '.call, do not touch anything if users comes from PEID (i.e. there is the id_token in session)' do
      #given
      session = {id_token: 'any_token'}
      asker = Asker.new({v_age: '42'})
      before_answer_count = Answer.count
      #when
      res = SaveAnswer.new.call(asker, session)
      #then
      after_answer_count = Answer.count
      assert_equal before_answer_count, after_answer_count
    end

    test '.call, do not touch anything if already a flag in session' do
      #given
      session = {saved_answer: 'anything'}
      asker = Asker.new({v_age: '42'})
      before_answer_count = Answer.count
      #when
      res = SaveAnswer.new.call(asker, session)
      #then
      after_answer_count = Answer.count
      assert_equal before_answer_count, after_answer_count
      assert_equal session[:saved_answer], 'anything'
    end

    test '.call, do not touch anything if wrong input' do
      #given
      session = {}
      asker = 'not_an_asker_but_a_string'
      before_answer_count = Answer.count
      #when
      res = SaveAnswer.new.call(asker, session)
      #then
      after_answer_count = Answer.count
      assert_equal before_answer_count, after_answer_count
      assert_nil session[:saved_answer]
    end

    test '.call, do not touch anything if Asker attributes are empty' do
      #given
      session = {}
      empty_asker = Asker.new
      before_answer_count = Answer.count
      #when
      res = SaveAnswer.new.call(empty_asker, session)
      #then
      after_answer_count = Answer.count
      assert_equal before_answer_count, after_answer_count
      assert_nil session[:saved_answer]
    end

end
