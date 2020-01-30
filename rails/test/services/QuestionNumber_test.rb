require "test_helper"

class QuestionNumberTest < ActiveSupport::TestCase
  
  test '.value for question "inscription" is always 1' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(Asker.new)
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("inscription")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(1, res)
  end
  test '.value for question "category" is always 2' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(Asker.new)
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("category")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(2, res)
  end
  test '.value for question "allocation" is 2 if asker is "non_inscrit"' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(_unsubcribed_asker)
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("allocation")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(2, res)
  end
  test '.value for question "allocation" is 3 if asker is "inscrit"' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(_subcribed_asker)
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("allocation")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(3, res)
  end
  test '.value for question "are" is 4 at most' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(_subcribed_asker)
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("are")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(4, res)
  end
  test '.value for question "are" is 3 if asker is "non_inscrit"' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(_unsubcribed_asker)
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("are")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(3, res)
  end
  test '.value for question "age" is 5 at most' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(_subcribed_asker(_asker_with_montant))
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("age")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(5, res)
  end
  test '.value for question "age" is 4 if "avec montant, non inscrit"' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(_unsubcribed_asker(_asker_with_montant))
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("age")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(4, res)
  end
  test '.value for question "age" is 4 if "sans montant, inscrit"' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(_subcribed_asker(_asker_without_montant))
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("age")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(4, res)
  end
  test '.value for question "age" is 3 if "sans montant, non inscrit"' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(_unsubcribed_asker(_asker_without_montant))
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("age")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(3, res)
  end

  test '.value for question "grade" is 6 at most' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(_subcribed_asker(_asker_with_montant))
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("grade")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(6, res)
  end
  test '.value for question "grade" is 5 if "avec montant, non inscrit"' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(_unsubcribed_asker(_asker_with_montant))
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("grade")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(5, res)
  end
  test '.value for question "grade" is 5 if "sans montant, inscrit"' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(_subcribed_asker(_asker_without_montant))
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("grade")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(5, res)
  end
  test '.value for question "grade" is 4 if "sans montant, non inscrit"' do
    #given
    allow_any_instance_of(QuestionNumber).to receive(:_get_asker).and_return(_unsubcribed_asker(_asker_without_montant))
    allow_any_instance_of(QuestionNumber).to receive(:_current_question).and_return("grade")
    #when
    res = QuestionNumber.new(nil).value
    #then
    assert_equal(4, res)
  end



  def _subcribed_asker(existing_asker=nil)
    res = existing_asker || Asker.new
    res.v_duree_d_inscription = 'more_than_a_year'
    res
  end

  def _unsubcribed_asker(existing_asker=nil)
    res = existing_asker || Asker.new
    res.v_duree_d_inscription = 'non_inscrit'
    res
  end

  def _asker_without_montant(existing_asker=nil)
    res = existing_asker || Asker.new
    res.v_allocation_type = 'RSA'
    res
  end

  def _asker_with_montant(existing_asker=nil)
    res = existing_asker || Asker.new
    res.v_allocation_type = 'ASS_AER_APS_AS-FNE'
    res
  end

end
