require "test_helper"

class QuestionManagerTest < ActiveSupport::TestCase
  

  test ".getNextPath empty args, go to inscription screen by default" do
    #given
    #when
    res = QuestionManager.new.getNextPath
    #then
    assert_equal("/inscription_questions/new", res)
  end

  test ".getNextPath go from inscription to category, by default" do
    #given
    referer = 'inscription'
    form = Struct.new(:value).new('')
    #when
    res = QuestionManager.new.getNextPath(referer, form)
    #then
    assert_equal("/category_questions/new", res)
  end

  test ".getNextPath go from inscription to allocation, if no-subscription" do
    #given
    referer = 'inscription'
    form = Struct.new(:value).new('non_inscrit')
    #when
    res = QuestionManager.new.getNextPath(referer, form)
    #then
    assert_equal("/allocation_questions/new", res)
  end

  test ".getNextPath go from category to allocation" do
    #given
    referer = 'category'
    form = Struct.new(:value).new('')
    #when
    res = QuestionManager.new.getNextPath(referer, form)
    #then
    assert_equal("/allocation_questions/new", res)
  end

  test ".getNextPath go from allocation to age, by default" do
    #given
    referer = 'allocation'
    form = Struct.new(:type).new('')
    #when
    res = QuestionManager.new.getNextPath(referer, form)
    #then
    assert_equal("/age_questions/new", res)
  end

  test ".getNextPath go from allocation to A.R.E, if type of allocation is 'ASS_AER_APS_AS-FNE'" do
    #given
    referer = 'allocation'
    form = Struct.new(:type).new('ASS_AER_APS_AS-FNE')
    #when
    res = QuestionManager.new.getNextPath(referer, form)
    #then
    assert_equal("/are_questions/new", res)
  end

  test ".getNextPath go from allocation to A.R.E, if type of allocation is 'ARE_ASP'" do
    #given
    referer = 'allocation'
    form = Struct.new(:type).new('ARE_ASP')
    #when
    res = QuestionManager.new.getNextPath(referer, form)
    #then
    assert_equal("/are_questions/new", res)
  end

  test ".getNextPath go from A.R.E to age" do
    #given
    referer = 'are'
    form = Struct.new(:type).new('')
    #when
    res = QuestionManager.new.getNextPath(referer, form)
    #then
    assert_equal("/age_questions/new", res)
  end

  test ".getNextPath go from age to grade" do
    #given
    referer = 'age'
    form = Struct.new(:type).new('')
    #when
    res = QuestionManager.new.getNextPath(referer, form)
    #then
    assert_equal("/grade_questions/new", res)
  end

  test ".getNextPath go from grade to address" do
    #given
    referer = 'grade'
    form = Struct.new(:type).new('')
    #when
    res = QuestionManager.new.getNextPath(referer, form)
    #then
    assert_equal("/address_questions/new", res)
  end

  test ".getNextPath go from address to other" do
    #given
    referer = 'address'
    form = Struct.new(:value).new('')
    #when
    res = QuestionManager.new.getNextPath(referer, form)
    #then
    assert_equal("/other_questions/new", res)
  end

end
