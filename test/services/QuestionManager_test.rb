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

  test ".getNextPath go from other to results" do
    #given
    referer = 'other'
    form = 'the_id'
    #when
    res = QuestionManager.new.getNextPath(referer, form)
    #then
    assert_equal("/aides?for_id=the_id", res)
  end


  test ".getPreviousPath go from other back to address page" do
    #given
    referer = 'other'
    #when
    res = QuestionManager.new.getPreviousPath(referer, Asker.new)
    #then
    assert_equal("/address_questions/new", res)    
  end

  test ".getPreviousPath go from address back to grade page" do
    #given
    referer = 'address'
    #when
    res = QuestionManager.new.getPreviousPath(referer, Asker.new)
    #then
    assert_equal("/grade_questions/new", res)    
  end

  test ".getPreviousPath go from grade back to age page" do
    #given
    referer = 'grade'
    #when
    res = QuestionManager.new.getPreviousPath(referer, Asker.new)
    #then
    assert_equal("/age_questions/new", res)    
  end

  test ".getPreviousPath go from age back to A.R.E, if asker has are" do
    #given
    referer = 'age'
    asker = Asker.new(v_allocation_value_min: "320")
    #when
    res = QuestionManager.new.getPreviousPath(referer, asker)
    #then
    assert_equal("/are_questions/new", res)    
  end

  test ".getPreviousPath go from age back to allocation, if asker has are that is not an integer" do
    #given
    referer = 'age'
    asker = Asker.new(v_allocation_value_min: "verybadinput")
    #when
    res = QuestionManager.new.getPreviousPath(referer, asker)
    #then
    assert_equal("/allocation_questions/new", res)    
  end

  test ".getPreviousPath go from age back to allocation, if asker has no ARE" do
    #given
    referer = 'age'
    #when
    res = QuestionManager.new.getPreviousPath(referer, Asker.new)
    #then
    assert_equal("/allocation_questions/new", res)    
  end

  test ".getPreviousPath go from ARE back to allocation" do
    #given
    referer = 'are'
    #when
    res = QuestionManager.new.getPreviousPath(referer, Asker.new)
    #then
    assert_equal("/allocation_questions/new", res)    
  end

  test ".getPreviousPath go from allocation back to category" do
    #given
    referer = 'allocation'
    #when
    res = QuestionManager.new.getPreviousPath(referer, Asker.new)
    #then
    assert_equal("/category_questions/new", res)    
  end

  test ".getPreviousPath go from allocation back to inscription page, if category is not applicable" do
    #given
    referer = 'allocation'
    asker = Asker.new(v_category: 'not_applicable')
    #when
    res = QuestionManager.new.getPreviousPath(referer, asker)
    #then
    assert_equal("/inscription_questions/new", res)    
  end

  test ".getPreviousPath go from category back to inscription" do
    #given
    referer = 'category'
    #when
    res = QuestionManager.new.getPreviousPath(referer, Asker.new)
    #then
    assert_equal("/inscription_questions/new", res)    
  end

  test ".getPreviousPath go from inscription back to index page" do
    #given
    referer = 'inscription'
    #when
    res = QuestionManager.new.getPreviousPath(referer, Asker.new)
    #then
    assert_equal("/", res)    
  end

end
