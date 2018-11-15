require 'rails_helper'

describe WhitelistAidService do
  describe '.for_aid_in_list' do
    let!(:contract_type){create(:contract_type, :contract_type_1)}
    let!(:custom_parent_filter){create(:custom_parent_filter, name: "parent a")}
    let!(:aid_hash) {
          {"id"=>26,
           "name"=>"Volontariat international (VI)",
           "slug"=>"vi-volontariat-international",
           "short_description"=>
            "Mission rémunérée qui permet d'avoir une première expérience à l'international",
           "ordre_affichage"=>63,
           "contract_type_id"=>contract_type.id,
           "filters"=>[{"id"=>7, "slug"=>"travailler-a-l-international"}],
           "custom_filters"=>[{"id"=>5, "slug"=>"zen_3", "custom_parent_filter_id"=>custom_parent_filter.id}],
           "level3_filters"=>[{"id"=>1, "slug"=>"gerer-un-probleme-d-alcool"}],
           "eligibility"=>"eligible",
           "unwanted_key"=>42}
    }
    it 'Should remove undesirable keys' do
      #given
      expect(aid_hash["unwanted_key"]).not_to be nil
      #when
      sut = WhitelistAidService.new.for_aid_in_list(aid_hash)
      #then
      pp sut
      expect(sut["unwanted_key"]).to be nil
    end
    it 'Should extract properly custom filters' do
      #given
      #when
      sut = WhitelistAidService.new.for_aid_in_list(aid_hash)
      #then
      expect(sut["custom_filters"]).to eq [{"slug"=>"zen_3", "parent_slug"=>"parent-a"}]
    end
  end
end
