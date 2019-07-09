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

end
