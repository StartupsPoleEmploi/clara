require "test_helper"

class SerializeResultsServiceTest < ActiveSupport::TestCase
  
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
    assert_equal("children-1,children-2,children-3",res)
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

  def hash_for(a_filter)
    {"id"=>a_filter.id, "slug"=>a_filter.slug}
  end

  def ely_factory(an_id, simple_filters, need_filters=[], custom_filters=[])
    {"id"=>an_id,
      "name"                 => "Aide Number #{an_id}",
      "slug"                 => "aide-number-#{an_id}",
      "short_description"    => "aide générée automatiquement, numéro #{an_id}",
      "ordre_affichage"      => [1,2,3,4].sample,
      "contract_type_id"     => [1,2,3,4].sample,
      "filters"              => simple_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "need_filters"         => need_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "custom_filters"       => custom_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "eligibility"          => ["eligible", "ineligible", "uncertain"].sample
    }
  end

  # System under test
  def sut
    SerializeResultsService.get_instance
  end

end
