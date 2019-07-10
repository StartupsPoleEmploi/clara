require "test_helper"

class SerializeResultsServiceFilterTest < ActiveSupport::TestCase
  
  #
  # NO FILTER
  #
  test '_.filter Do not affect elies if no filter is required' do
    #given
    elies = []
            .push(ely_factory(42, [], [], []))
            .push(ely_factory(43, [], [], []))
    simple_filters, need_filters, custom_filters, custom_parent_filters = nil
    #when
    res = sut._filter(elies, simple_filters, need_filters, custom_filters, custom_parent_filters)
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
    need_filters, custom_filters, custom_parent_filters = nil
    #when
    res = sut._filter(elies, simple_filters, need_filters, custom_filters, custom_parent_filters)
    #then
    assert_equal(0, res.size)
  end
  # test '_.filter Is able to filter according to simple filter only, simplest scenario' do
  #   elies = []
  #           .push(ely_factory(42, [se_divertir], []))
  #           .push(ely_factory(43, [], []))
  #   simple_filters = "se-divertir"
  #   need_filters = nil
  #   custom_filters = nil
  #   custom_parent_filters = nil

  #   res = sut._filter(elies, simple_filters, need_filters, custom_filters, custom_parent_filters)
  #   assert_equal(1,res.size)
  #   assert_equal(42,res[0]["id"])
  # end
  # test '_.filter Is able to resist to doubled filter' do
  #   elies = []
  #           .push(ely_factory(42, [se_divertir], []))
  #           .push(ely_factory(43, [], []))
  #   simple_filters = "se-divertir,se-divertir"
  #   need_filters = nil
  #   custom_filters = nil
  #   custom_parent_filters = nil

  #   res = sut._filter(elies, simple_filters, need_filters, custom_filters, custom_parent_filters)
  #   assert_equal(1,res.size)
  #   assert_equal(42,res[0]["id"])
  # end
  # test '_.filter Is able to filter according to simple filter only, even when requiring multiple filters, last position' do
  #   elies = []
  #           .push(ely_factory(42, [se_divertir, se_deplacer], []))
  #           .push(ely_factory(43, [], []))
  #   simple_filters = "se-mouvoir,se-divertir"
  #   need_filters = nil
  #   custom_filters = nil
  #   custom_parent_filters = nil

  #   res = sut._filter(elies, simple_filters, need_filters, custom_filters, custom_parent_filters)
  #   assert_equal(1,res.size)
  #   assert_equal(42,res[0]["id"])
  # end
  # test '_.filter Is able to filter according to simple filter only, even when requiring multiple filters, first position' do
  #   elies = []
  #           .push(ely_factory(42, [se_divertir, se_deplacer], []))
  #           .push(ely_factory(43, [], []))
  #   simple_filters = "se-divertir,se-mouvoir"
  #   need_filters = nil
  #   custom_filters = nil
  #   custom_parent_filters = nil

  #   res = sut._filter(elies, simple_filters, need_filters, custom_filters, custom_parent_filters)
  #   assert_equal(1,res.size)
  #   assert_equal(42,res[0]["id"])
  # end
  # test '_.filter Is able to filter according to simple filter only, even when requiring multiple filters twice' do
  #   elies = []
  #           .push(ely_factory(42, [se_divertir, se_deplacer], []))
  #           .push(ely_factory(43, [], []))
  #   simple_filters = "se-divertir,se-deplacer"
  #   need_filters = nil
  #   custom_filters = nil
  #   custom_parent_filters = nil

  #   res = sut._filter(elies, simple_filters, need_filters, custom_filters, custom_parent_filters)
  #   assert_equal(1,res.size)
  #   assert_equal(42,res[0]["id"])
  # end
  # test '_.filter Is able to filter according to simple filter only, even when requiring inexisting filter' do
  #   elies = []
  #           .push(ely_factory(42, [se_divertir, se_deplacer], []))
  #           .push(ely_factory(43, [], []))
  #   simple_filters = "inexisting,se-divertir"
  #   need_filters = nil
  #   custom_filters = nil
  #   custom_parent_filters = nil

  #   res = sut._filter(elies, simple_filters, need_filters, custom_filters, custom_parent_filters)
  #   assert_equal(1,res.size)
  #   assert_equal(42,res[0]["id"])
  # end
  # test '_.filter Is able to filter multiple eligies with simple filter' do
  #   elies = []
  #           .push(ely_factory(42, [se_divertir, se_deplacer], []))
  #           .push(ely_factory(43, [], []))
  #           .push(ely_factory(44, [se_divertir], []))
  #   simple_filters = "inexisting,se-divertir"
  #   need_filters = nil
  #   custom_filters = nil
  #   custom_parent_filters = nil

  #   res = sut._filter(elies, simple_filters, need_filters, custom_filters, custom_parent_filters)
  #   assert_equal(2,res.size)
  #   assert_equal(42,res[0]["id"])
  #   assert_equal(44,res[1]["id"])
  # end


  
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
