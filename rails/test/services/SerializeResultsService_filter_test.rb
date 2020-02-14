require "test_helper"

class SerializeResultsServiceFilterTest < ActiveSupport::TestCase
  
  def setup
    allow(JsonModelsService).to receive(:filters).and_return(realistic_filters)
  end


  #
  # NO FILTER
  #
  test '_.filter Do not affect elies if no filter is required' do
    #given
    elies = []
            .push(ely_factory(42, [], [], []))
            .push(ely_factory(43, [], [], []))
    simple_filters = nil
    #when
    res = sut._filter(elies, simple_filters)
    #then
    assert_equal(2, res.size)
    assert_equal(42, res[0]["id"])
    assert_equal(43, res[1]["id"])
  end

  #
  # SIMPLE FILTER
  #
  test '_.filter Removed all eligies if filter is required, but eligies are affected to any filter' do
    #given
    elies = []
            .push(ely_factory(42, [], []))
            .push(ely_factory(43, [], []))
    simple_filters = "se-divertir"
    
    #when
    res = sut._filter(elies, simple_filters)
    #then
    assert_equal(0, res.size)
  end
  test '_.filter Is able to filter according to simple filter only, simplest scenario' do
    #given
    elies = []
            .push(ely_factory(42, [se_divertir], []))
            .push(ely_factory(43, [], []))
    simple_filters = "se-divertir"
    need_filters, custom_filters, custom_parent_filters = nil
    #when
    res = sut._filter(elies, simple_filters)
    #then
    assert_equal(1,res.size)
    assert_equal(42,res[0]["id"])
  end
  test '_.filter Is able to resist to doubled filter' do
    #given
    elies = []
            .push(ely_factory(42, [se_divertir], []))
            .push(ely_factory(43, [], []))
    simple_filters = "se-divertir,se-divertir"
    need_filters, custom_filters, custom_parent_filters = nil
    #when
    res = sut._filter(elies, simple_filters)
    #then
    assert_equal(1,res.size)
    assert_equal(42,res[0]["id"])
  end
  test '_.filter Is able to filter according to simple filter only, even when requiring multiple filters, last position' do
    elies = []
            .push(ely_factory(42, [se_divertir, se_deplacer], []))
            .push(ely_factory(43, [], []))
    simple_filters = "se-mouvoir,se-divertir"

    res = sut._filter(elies, simple_filters)
    assert_equal(1,res.size)
    assert_equal(42,res[0]["id"])
  end
  test '_.filter Is able to filter according to simple filter only, even when requiring multiple filters, first position' do
    elies = []
            .push(ely_factory(42, [se_divertir, se_deplacer], []))
            .push(ely_factory(43, [], []))
    simple_filters = "se-divertir,se-mouvoir"

    res = sut._filter(elies, simple_filters)
    assert_equal(1,res.size)
    assert_equal(42,res[0]["id"])
  end
  test '_.filter Is able to filter according to simple filter only, even when requiring multiple filters twice' do
    elies = []
            .push(ely_factory(42, [se_divertir, se_deplacer], []))
            .push(ely_factory(43, [], []))
    simple_filters = "se-divertir,se-deplacer"

    res = sut._filter(elies, simple_filters)
    assert_equal(1,res.size)
    assert_equal(42,res[0]["id"])
  end
  test '_.filter Is able to filter according to simple filter only, even when requiring inexisting filter' do
    elies = []
            .push(ely_factory(42, [se_divertir, se_deplacer], []))
            .push(ely_factory(43, [], []))
    simple_filters = "inexisting,se-divertir"

    res = sut._filter(elies, simple_filters)
    assert_equal(1,res.size)
    assert_equal(42,res[0]["id"])
  end
  test '_.filter Is able to filter multiple eligies with simple filter' do
    elies = []
            .push(ely_factory(42, [se_divertir, se_deplacer], []))
            .push(ely_factory(43, [], []))
            .push(ely_factory(44, [se_divertir], []))
    simple_filters = "inexisting,se-divertir"

    res = sut._filter(elies, simple_filters)
    assert_equal(2,res.size)
    assert_equal(42,res[0]["id"])
    assert_equal(44,res[1]["id"])
  end

  def se_divertir
    Filter.new(realistic_filters.find{|e| e["slug"] == "se-divertir"})
  end

  def se_deplacer
    Filter.new(realistic_filters.find{|e| e["slug"] == "se-deplacer"})
  end

  def se_mouvoir
    Filter.new(realistic_filters.find{|e| e["slug"] == "se-mouvoir"})
  end

  def realistic_filters
    [
      {"id"=>1, "slug"=>"se-divertir", "name" => "se divertir"}, 
      {"id"=>2, "slug"=>"se-deplacer", "name" => "se deplacer"}, 
      {"id"=>3, "slug"=>"se-mouvoir", "name" => "se mouvoir"}, 
    ]
  end

  def ely_factory(an_id, simple_filters, need_filters=[], custom_filters=[])
    {"id"=>an_id,
      "name"                 => "Aide Number #{an_id}",
      "slug"                 => "aide-number-#{an_id}",
      "short_description"    => "aide générée automatiquement, numéro #{an_id}",
      "ordre_affichage"      => [1,2,3,4].sample,
      "contract_type_id"     => [1,2,3,4].sample,
      "filters"              => simple_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "eligibility"          => ["eligible", "ineligible", "uncertain"].sample
    }
  end

  # System under test
  def sut
    SerializeResultsService.get_instance
  end

end
