require 'rails_helper'

describe SerializeResultsService do

  def hash_for(a_filter)
    {"id"=>a_filter.id, "slug"=>a_filter.slug}
  end

  def ely_factory(an_id, simple_filters, level3_filters, custom_filters=[], custom_parent_filters=[])
    {"id"=>an_id,
      "name"                 => "Aide Number #{an_id}",
      "slug"                 => "aide-number-#{an_id}",
      "short_description"    => "aide générée automatiquement, numéro #{an_id}",
      "ordre_affichage"      => [1,2,3,4].sample,
      "contract_type_id"     => [1,2,3,4].sample,
      "filters"              => simple_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "level3_filters"       => level3_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "custom_filters"       => custom_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "custom_parent_filters"=> custom_parent_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "eligibility"          => ["eligible", "ineligible", "uncertain"].sample
    }
  end

  # System under test
  let(:sut) {SerializeResultsService.get_instance}
  
  describe '._filter' do
    let(:se_divertir) {create(:filter, :name => "se divertir")}
    let(:se_deplacer) {create(:filter, :name => "se deplacer")}
    let(:se_mouvoir) {create(:filter, :name => "se mouvoir")}

    let(:addiction) {create(:level3_filter, :name => "addiction")}
    let(:argent) {create(:level3_filter, :name => "argent")}

    let(:custom_filter_1) {create(:custom_filter, :name => "custom filter 1")}
    let(:custom_filter_2) {create(:custom_filter, :name => "custom filter 2")}

    let(:custom_parent_filter_1) {create(:custom_filter, :name => "custom parent filter 1")}
    let(:custom_parent_filter_2) {create(:custom_filter, :name => "custom parent filter 2")}

    #
    # NO FILTER
    #
    it 'Do not affect elies if no filter is required' do
      elies = []
              .push(ely_factory(42, [], [], []))
              .push(ely_factory(43, [], [], []))
      simple_filters = nil
      level3_filters = nil
      custom_filters = nil
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(2)
      expect(res[0]["id"]).to eq(42)
      expect(res[1]["id"]).to eq(43)
    end

    #
    # SIMPLE FILTER
    #
    it 'Removed all eligies if filter is required, but eligies are affected to any filter' do
      elies = []
              .push(ely_factory(42, [], []))
              .push(ely_factory(43, [], []))
      simple_filters = "se-divertir"
      level3_filters = nil
      custom_filters = nil
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(0)
    end
    it 'Is able to filter according to simple filter only, simplest scenario' do
      elies = []
              .push(ely_factory(42, [se_divertir], []))
              .push(ely_factory(43, [], []))
      simple_filters = "se-divertir"
      level3_filters = nil
      custom_filters = nil
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(1)
      expect(res[0]["id"]).to eq(42)
    end
    it 'Is able to filter according to simple filter only, even when requiring multiple filters, last position' do
      elies = []
              .push(ely_factory(42, [se_divertir, se_deplacer], []))
              .push(ely_factory(43, [], []))
      simple_filters = "se-mouvoir,se-divertir"
      level3_filters = nil
      custom_filters = nil
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(1)
      expect(res[0]["id"]).to eq(42)
    end
    it 'Is able to filter according to simple filter only, even when requiring multiple filters, first position' do
      elies = []
              .push(ely_factory(42, [se_divertir, se_deplacer], []))
              .push(ely_factory(43, [], []))
      simple_filters = "se-divertir,se-mouvoir"
      level3_filters = nil
      custom_filters = nil
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(1)
      expect(res[0]["id"]).to eq(42)
    end
    it 'Is able to filter according to simple filter only, even when requiring multiple filters twice' do
      elies = []
              .push(ely_factory(42, [se_divertir, se_deplacer], []))
              .push(ely_factory(43, [], []))
      simple_filters = "se-divertir,se-deplacer"
      level3_filters = nil
      custom_filters = nil
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(1)
      expect(res[0]["id"]).to eq(42)
    end
    it 'Is able to filter according to simple filter only, even when requiring inexisting filter' do
      elies = []
              .push(ely_factory(42, [se_divertir, se_deplacer], []))
              .push(ely_factory(43, [], []))
      simple_filters = "inexisting,se-divertir"
      level3_filters = nil
      custom_filters = nil
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(1)
      expect(res[0]["id"]).to eq(42)
    end
    it 'Is able to filter multiple eligies with simple filter' do
      elies = []
              .push(ely_factory(42, [se_divertir, se_deplacer], []))
              .push(ely_factory(43, [], []))
              .push(ely_factory(44, [se_divertir], []))
      simple_filters = "inexisting,se-divertir"
      level3_filters = nil
      custom_filters = nil
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(2)
      expect(res[0]["id"]).to eq(42)
      expect(res[1]["id"]).to eq(44)
    end


    #
    # LEVEL3 FILTER
    #
    it 'Is able to filter multiple eligies with level3 filters' do
      elies = []
              .push(ely_factory(42, [], []))
              .push(ely_factory(43, [], [argent, addiction]))
              .push(ely_factory(44, [], [addiction]))
      simple_filters = nil
      level3_filters = "addiction,argent"
      custom_filters = nil
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(2)
      expect(res[0]["id"]).to eq(43)
      expect(res[1]["id"]).to eq(44)
    end

    #
    # CUSTOM FILTER
    #
    it 'Select corresponding custom filters' do
      elies = []
              .push(ely_factory(42, [], [], [custom_filter_1]))
              .push(ely_factory(43, [], [addiction], []))
      simple_filters = nil
      level3_filters = nil
      custom_filters = "custom-filter-1"
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(1)
      expect(res[0]["id"]).to eq(42)
    end
    it 'Select corresponding custom filters (more complicated example)' do
      elies = []
              .push(ely_factory(42, [], [], [custom_filter_1]))
              .push(ely_factory(43, [], [addiction], []))
              .push(ely_factory(44, [se_divertir, se_deplacer], [addiction], [custom_filter_2, custom_filter_1]))
              .push(ely_factory(45, [se_divertir, se_deplacer, se_mouvoir], [addiction], []))
      simple_filters = nil
      level3_filters = nil
      custom_filters = "custom-filter-42,custom-filter-1,custom-filter-2"
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(2)
      expect(res[0]["id"]).to eq(42)
      expect(res[1]["id"]).to eq(44)
    end

    #
    # CUSTOM PARENT FILTER
    #
    it 'Select corresponding custom parent filters' do
      elies = []
              .push(ely_factory(42, [], [], [custom_filter_1]))
              .push(ely_factory(43, [], [addiction], [], [custom_parent_filter_1]))
      simple_filters = nil
      level3_filters = nil
      custom_filters = nil
      custom_parent_filters = "custom-parent-filter-1"

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(1)
      expect(res[0]["id"]).to eq(43)
    end

    #
    # LEVEL3 FILTER AND SIMPLE FILTER
    #
    it 'Is able to filter according to both level3 and simple filter' do
      elies = []
              .push(ely_factory(42, [se_divertir, se_deplacer], [addiction]))
              .push(ely_factory(43, [se_divertir], [argent]))
              .push(ely_factory(44, [se_deplacer], [argent]))
      simple_filters = "se-divertir,se-regarder"
      level3_filters = "argent"
      custom_filters = nil
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(1)
      expect(res[0]["id"]).to eq(43)     
    end
  end
end
