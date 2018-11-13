require 'rails_helper'

describe SerializeResultsService do

  def hash_for(a_filter)
    {"id"=>a_filter.id, "slug"=>a_filter.slug}
  end

  describe '._filter' do
    let(:se_divertir) {create(:filter, :name => "se divertir")}
    let(:se_deplacer) {create(:filter, :name => "se deplacer")}
    let(:se_reprendre) {create(:filter, :name => "se reprendre")}

    let(:addiction) {create(:level3_filter, :name => "addiction")}
    let(:argent) {create(:level3_filter, :name => "argent")}
    let(:attente) {create(:level3_filter, :name => "attente")}

    let(:elies) {
      [
        {"id"=>8,
          "name"=>"Aide Amob",
          "slug"=>"aide-amob",
          "short_description"=>"aide pour majeurs ou intermittent du spectacle",
          "ordre_affichage"=>1,
          "contract_type_id"=>4,
          "filters"=>[],
          "level3_filters"=>[hash_for(attente), hash_for(argent)],
          "eligibility"=>"ineligible"},
        {"id"=>9,
          "name"=>"Aide Adulte ou Spectacle",
          "slug"=>"aide-adulte-ou-spectacle",
          "short_description"=>"aide pour majeurs ou intermittent du spectacle",
          "ordre_affichage"=>0,
          "contract_type_id"=>3,
          "filters"=>[hash_for(se_deplacer), hash_for(se_divertir)],
          "level3_filters"=>[],
          "eligibility"=>"eligible"},
       {"id"=>10,
          "name"=>"Aide Adulte",
          "slug"=>"aide-adulte",
          "short_description"=>"aide réservée aux plus de 18 ans",
          "ordre_affichage"=>0,
          "contract_type_id"=>1,
          "filters"=>[hash_for(se_deplacer)],
          "level3_filters"=>[],
          "eligibility"=>"uncertain"},
       {"id"=>11,
          "name"=>"Dispositif insertion",
          "slug"=>"disposition-insertion",
          "short_description"=>"Un disposition d'insertion",
          "ordre_affichage"=>12,
          "contract_type_id"=>2,
          "filters"=>[hash_for(se_reprendre)],
          "level3_filters"=>[hash_for(addiction), hash_for(argent)],
          "eligibility"=>"uncertain"}
      ]
    }
    before do
      create :rule, :be_an_adult, name: 'an_adult'
    end
    it 'Is able to filter according to simple filter only' do
      simple_filters = "se-regarder,se-divertir"
      level3_filters = nil

      res = SerializeResultsService.get_instance._filter(elies, simple_filters, level3_filters)
      expect(res.size).to eq(1)
      expect(res[0]["id"]).to eq(9)
    end
    it "Is able to filter according to level3 filter only" do
      simple_filters = nil
      level3_filters = "attente"

      res = SerializeResultsService.get_instance._filter(elies, simple_filters, level3_filters)
      expect(res.size).to eq(1)
    end
    it 'Is able to filter according to both level3 and simple filter' do
      simple_filters = "se-reprendre,se-deplacer"
      level3_filters = "argent,addiction"

      res = SerializeResultsService.get_instance._filter(elies, simple_filters, level3_filters)
      expect(res.size).to eq(1)      
    end
    it 'Returns empty eligies if input are not properly set'
  end
end
