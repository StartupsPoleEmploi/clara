require 'rails_helper'

describe SerializeResultsService do

  def hash_for(a_filter)
    {"id"=>a_filter.id, "slug"=>a_filter.slug}
  end

  def ely_factory(an_id, simple_filters, level3_filters=[], custom_filters=[])
    {"id"=>an_id,
      "name"                 => "Aide Number #{an_id}",
      "slug"                 => "aide-number-#{an_id}",
      "short_description"    => "aide générée automatiquement, numéro #{an_id}",
      "ordre_affichage"      => [1,2,3,4].sample,
      "contract_type_id"     => [1,2,3,4].sample,
      "filters"              => simple_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "level3_filters"       => level3_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "custom_filters"       => custom_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "eligibility"          => ["eligible", "ineligible", "uncertain"].sample
    }
  end

  # System under test
  let(:sut) {SerializeResultsService.get_instance}


  describe '._extract_custom_childrens' do
    let!(:custom_parent_filter_a) {create(:custom_parent_filter, :name => "parent a")}
    let!(:custom_parent_filter_b) {create(:custom_parent_filter, :name => "parent b")}

    let!(:custom_filter_1) {create(:custom_filter, :name => "children 1", custom_parent_filter: custom_parent_filter_a)}
    let!(:custom_filter_2) {create(:custom_filter, :name => "children 2", custom_parent_filter: custom_parent_filter_a)}
    let!(:custom_filter_3) {create(:custom_filter, :name => "children 3", custom_parent_filter: custom_parent_filter_b)}

    it "Should convert a list of comma-separated parent's slug into a list of children slug" do
      #given
      #when
      res = sut._extract_custom_childrens("parent-a,parent-b")
      #then
      expect(res).to eq("children-1,children-2,children-3")
    end
    
    it "Should also works with one parent" do
      #given
      #when
      res = sut._extract_custom_childrens("parent-a")
      #then
      expect(res).to eq("children-1,children-2")
    end
    
    it "Should return empty String if nothing is given as input" do
      #given
      #when
      res = sut._extract_custom_childrens("")
      #then
      expect(res).to eq("")
    end

    it "Should return empty String if wrong input is given" do
      #given
      #when
      res = sut._extract_custom_childrens(Date.new)
      #then
      expect(res).to eq("")
    end

    it "Should throw error for unexisting parent" do
      #given
      #when
      #then
      expect{sut._extract_custom_childrens("inexisting")}.to raise_error(NoMethodError)
    end
    
  end

  describe '._filter' do
    let(:se_divertir) {create(:filter, :name => "se divertir")}
    let(:se_deplacer) {create(:filter, :name => "se deplacer")}
    let(:se_mouvoir) {create(:filter, :name => "se mouvoir")}

    let(:addiction) {create(:level3_filter, :name => "addiction")}
    let(:argent) {create(:level3_filter, :name => "argent")}


    let(:custom_parent_filter_a) {create(:custom_parent_filter, :name => "custom parent filter a")}
    let(:custom_parent_filter_b) {create(:custom_parent_filter, :name => "custom parent filter b")}

    let(:custom_filter_1) {create(:custom_filter, :name => "custom filter 1", custom_parent_filter: custom_parent_filter_a)}
    let(:custom_filter_2) {create(:custom_filter, :name => "custom filter 2", custom_parent_filter: custom_parent_filter_a)}
    let(:custom_filter_3) {create(:custom_filter, :name => "custom filter 3", custom_parent_filter: custom_parent_filter_b)}

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
    it 'Is able to resist to doubled filter' do
      elies = []
              .push(ely_factory(42, [se_divertir], []))
              .push(ely_factory(43, [], []))
      simple_filters = "se-divertir,se-divertir"
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
    it 'Custom parent filters actually pick underlying custom filter' do
      elies = []
              .push(ely_factory(42, [], [], [custom_filter_1]))
              .push(ely_factory(43, [], [], [custom_filter_2]))
              .push(ely_factory(44, [], [], [custom_filter_3]))
      simple_filters = nil
      level3_filters = nil
      custom_filters = nil
      custom_parent_filters = "custom-parent-filter-a"

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(2)
      expect(res[0]["id"]).to eq(42)
      expect(res[1]["id"]).to eq(43)
    end
    it 'Custom parent is actually equivalent to select all child filter of parent' do
      elies = []
              .push(ely_factory(42, [], [], [custom_filter_1]))
              .push(ely_factory(43, [], [], [custom_filter_2]))
              .push(ely_factory(44, [], [], [custom_filter_3]))
      simple_filters = nil
      level3_filters = nil
      custom_filters = "custom-filter-1,custom-filter-2"
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(2)
      expect(res[0]["id"]).to eq(42)
      expect(res[1]["id"]).to eq(43)
    end

    #
    # COMBINATIONS
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
    it 'Is able to combine all filters' do
      elies = []
              .push(ely_factory(41, [se_mouvoir], [addiction], []))
              .push(ely_factory(42, [se_divertir, se_deplacer], [addiction], [custom_filter_1]))
              .push(ely_factory(43, [se_divertir], [argent], [custom_filter_1]))
              .push(ely_factory(44, [se_deplacer], [argent], []))
              .push(ely_factory(45, [se_divertir], [argent], [custom_filter_2]))
              .push(ely_factory(46, [se_divertir], [argent,addiction], [custom_filter_1,custom_filter_2]))
      simple_filters = "se-divertir,se-regarder"
      level3_filters = "argent,inexisting"
      custom_filters = "inexisting,custom-filter-1,inexisting_too"
      # custom_parent_filters = "custom-parent-filter-1,custom-parent-filter-2"
      custom_parent_filters = nil

      res = sut._filter(elies, simple_filters, level3_filters, custom_filters, custom_parent_filters)
      expect(res.size).to eq(2)
      expect(res[0]["id"]).to eq(43)     
      expect(res[1]["id"]).to eq(46)     
    end
  end
end
