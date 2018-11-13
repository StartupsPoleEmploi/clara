require 'rails_helper'

describe SerializeResultsService do

  def hash_for(a_filter)
    {"id"=>a_filter.id, "slug"=>a_filter.slug}
  end

  def elies_factory(an_id, simple_filters, level3_filters)
    {"id"=>an_id,
      "name"              => "Aide Number #{an_id}",
      "slug"              => "aide-number-#{an_id}",
      "short_description" => "aide générée automatiquement, numéro #{an_id}",
      "ordre_affichage"   => [1,2,3,4].sample,
      "contract_type_id"  => [1,2,3,4].sample,
      "filters"           => simple_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "level3_filters"    => level3_filters.map { |e| {"id"=>e.id, "slug"=>e.slug} },
      "eligibility"       => ["eligible", "ineligible", "uncertain"].sample
    }
  end

  describe '._filter' do
    let(:se_divertir) {create(:filter, :name => "se divertir")}
    let(:se_deplacer) {create(:filter, :name => "se deplacer")}
    let(:se_reprendre) {create(:filter, :name => "se reprendre")}

    let(:addiction) {create(:level3_filter, :name => "addiction")}
    let(:argent) {create(:level3_filter, :name => "argent")}
    let(:attente) {create(:level3_filter, :name => "attente")}


    it 'Is able to filter according to simple filter only' do
      elies = []
              .push(elies_factory(42, [se_divertir, se_deplacer], []))
              .push(elies_factory(43, [], []))
      simple_filters = "se-regarder,se-divertir"
      level3_filters = nil

      res = SerializeResultsService.get_instance._filter(elies, simple_filters, level3_filters)
      expect(res.size).to eq(1)
      expect(res[0]["id"]).to eq(42)
    end
    it "Is able to filter according to level3 filter only" do
      elies = []
              .push(elies_factory(42, [se_divertir, se_deplacer], []))
              .push(elies_factory(43, [], [argent]))
      simple_filters = nil
      level3_filters = "argent,addiction"

      res = SerializeResultsService.get_instance._filter(elies, simple_filters, level3_filters)
      expect(res.size).to eq(1)
      expect(res[0]["id"]).to eq(43)
    end
    it 'Is able to filter according to both level3 and simple filter' do
      elies = []
              .push(elies_factory(42, [se_divertir, se_deplacer], [addiction]))
              .push(elies_factory(43, [se_divertir], [argent]))
              .push(elies_factory(44, [se_deplacer], [argent]))
      simple_filters = "se-divertir,se-regarder"
      level3_filters = "argent"

      res = SerializeResultsService.get_instance._filter(elies, simple_filters, level3_filters)
      expect(res.size).to eq(1)
      expect(res[0]["id"]).to eq(43)     
    end
    it 'Returns empty eligies if input are not properly set'
  end
end
