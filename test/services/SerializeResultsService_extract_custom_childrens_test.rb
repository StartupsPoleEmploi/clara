require "test_helper"

class SerializeResultsServiceExtractCustomChildrensTest < ActiveSupport::TestCase
  
  test "._extract_custom_childrens Should convert a list of comma-separated parent's slug into a list of children slug" do
    #given
    allow(JsonModelsService).to receive(:custom_parent_filters).and_return(realistic_custom_parent_filters)
    allow(JsonModelsService).to receive(:custom_filters).and_return(realistic_custom_filters)
    #when
    res = sut._extract_custom_childrens("parent-a,parent-b")
    #then
    assert_equal("children-1,children-2,children-3",res)
  end
  
  test "._extract_custom_childrens Should also work with one parent" do
    #given
    allow(JsonModelsService).to receive(:custom_parent_filters).and_return(realistic_custom_parent_filters)
    allow(JsonModelsService).to receive(:custom_filters).and_return(realistic_custom_filters)
    #when
    res = sut._extract_custom_childrens("parent-a")
    #then
    assert_equal("children-1,children-2", res)
  end
  
  test "._extract_custom_childrens Should return empty String if wrong input is given" do
    #given
    allow(JsonModelsService).to receive(:custom_parent_filters).and_return(realistic_custom_parent_filters)
    allow(JsonModelsService).to receive(:custom_filters).and_return(realistic_custom_filters)
    #when
    res = sut._extract_custom_childrens(Date.new)
    #then
    assert_equal("",res)
  end
  
  test "._extract_custom_childrens Should throw error if parent do not exists" do
    #given
    allow(JsonModelsService).to receive(:custom_parent_filters).and_return(realistic_custom_parent_filters)
    allow(JsonModelsService).to receive(:custom_filters).and_return(realistic_custom_filters)
    #then
    assert_raises NoMethodError do
      #when
      sut._extract_custom_childrens("inexisting")
    end
  end

  def realistic_custom_parent_filters
    [
      {"id"=>1, "slug"=>"parent-a"}, 
      {"id"=>2, "slug"=>"parent-b"}
    ]
  end

  def realistic_custom_filters
    [
      {"id"=>1, "slug"=>"children-1", "custom_parent_filter_id"=>1},
      {"id"=>2, "slug"=>"children-2", "custom_parent_filter_id"=>1},
      {"id"=>3, "slug"=>"children-3", "custom_parent_filter_id"=>2}
    ]
  end

  # System under test
  def sut
    SerializeResultsService.get_instance
  end

end
