require 'rails_helper'

describe SerializeResultsService do

  describe '._filter' do
    let(:se_divertir) {create(:filter, :name => "se divertir")}
    let(:se_deplacer) {create(:filter, :name => "se deplacer")}
    let(:addiction) {create(:level3_filter, :name => "addiction")}
    let(:argent) {create(:level3_filter, :name => "argent")}
    let(:elies) {
      [
        {"id"=>8,
          "name"=>"Aide Amob",
          "slug"=>"aide-amob",
          "short_description"=>"aide pour majeurs ou intermittent du spectacle",
          "ordre_affichage"=>1,
          "contract_type_id"=>4,
          "filters"=>[],
          "level3_filters"=>[{"id"=>addiction.id, "slug"=>addiction.slug}, {"id"=>argent.id, "slug"=>argent.slug}],
          "eligibility"=>"ineligible"},
        {"id"=>9,
          "name"=>"Aide Adulte ou Spectacle",
          "slug"=>"aide-adulte-ou-spectacle",
          "short_description"=>"aide pour majeurs ou intermittent du spectacle",
          "ordre_affichage"=>0,
          "contract_type_id"=>3,
          "filters"=>[{"id"=>se_deplacer.id, "slug"=>se_deplacer.slug}, {"id"=>se_divertir.id, "slug"=>se_divertir.slug}],
          "level3_filters"=>[],
          "eligibility"=>"eligible"},
       {"id"=>10,
          "name"=>"Aide Adulte",
          "slug"=>"aide-adulte",
          "short_description"=>"aide réservée aux plus de 18 ans",
          "ordre_affichage"=>0,
          "contract_type_id"=>1,
          "filters"=>[{"id"=>se_deplacer.id, "slug"=>se_deplacer.slug}],
          "level3_filters"=>[],
          "eligibility"=>"uncertain"}
      ]
    }
    before do
      create :rule, :be_an_adult, name: 'an_adult'
    end
    it 'Is able to filter according to simple filter only' do
      simple_filters = "garde-enfant,se-divertir"
      level3_filters = nil

      res = SerializeResultsService.get_instance._filter(elies, simple_filters, level3_filters)
      expect(res.size).to eq(1)
    end
    it "Is able to filter according to level3 filter only" do
      simple_filters = nil
      level3_filters = "garde-enfant,argent"

      res = SerializeResultsService.get_instance._filter(elies, simple_filters, level3_filters)
      expect(res.size).to eq(1)
    end
    it 'Is able to filter according to both level3 and simple filter'
    it 'Returns empty eligies if input are not properly set'
  end
end
