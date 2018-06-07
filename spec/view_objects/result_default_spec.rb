require 'rails_helper'

describe ResultDefault do

  describe '.sort_and_order_eligies' do
    
    it 'Cannot sort unexisting prop' do
      sut = ResultDefault.new(nil, sample)
      res = sut.sort_and_order("unexisting_prop")
      expect(res).to eq({})
    end

    it 'Can sort "flat_all_eligible"' do
      sut = ResultDefault.new(nil, sample)
      res = sut.sort_and_order("flat_all_eligible")
      expect(res).not_to eq({})
    end

    it 'Can sort "flat_all_ineligible"' do
      sut = ResultDefault.new(nil, sample)
      res = sut.sort_and_order("flat_all_eligible")
      expect(res).not_to eq({})
    end


    it 'Sort aids along "ordre_affichage" property' do
      sut = ResultDefault.new(nil, sample)
      res = sut.sort_and_order("flat_all_eligible")
      expect(res).to eq(
        {2=>
          [{"id"=>6,
            "name"=>"Aides aux bénéficiaires du RSA, ou adultes",
            "slug"=>"aides-aux-beneficiaires-du-rsa-ou-adultes",
            "short_description"=>"",
            "ordre_affichage"=>4,
            "contract_type_id"=>2,
            "filters"=>[{"id"=>1}, {"id"=>3}],
            "eligibility"=>"eligible"},
            {"id"=>4,
            "name"=>"Aides aux habitants en QPV ou adultes",
            "slug"=>"aides-aux-habitants-en-qpv-ou-adultes",
            "short_description"=>"",
            "ordre_affichage"=>5,
            "contract_type_id"=>2,
            "filters"=>[{"id"=>1}, {"id"=>2}],
            "eligibility"=>"eligible"},
           ]
        }
        )
    end


  end

  def sample
    {:flat_all_eligible=>
  [{"id"=>4,
    "name"=>"Aides aux habitants en QPV ou adultes",
    "slug"=>"aides-aux-habitants-en-qpv-ou-adultes",
    "short_description"=>"",
    "ordre_affichage"=>5,
    "contract_type_id"=>2,
    "filters"=>[{"id"=>1}, {"id"=>2}],
    "eligibility"=>"eligible"},
   {"id"=>6,
    "name"=>"Aides aux bénéficiaires du RSA, ou adultes",
    "slug"=>"aides-aux-beneficiaires-du-rsa-ou-adultes",
    "short_description"=>"",
    "ordre_affichage"=>4,
    "contract_type_id"=>2,
    "filters"=>[{"id"=>1}, {"id"=>3}],
    "eligibility"=>"eligible"}],
 :flat_all_uncertain=>
  [{"id"=>2,
    "name"=>"Aide aux habitants en zone QPV",
    "slug"=>"aide-aux-habitants-en-zone-qpv",
    "short_description"=>"",
    "ordre_affichage"=>1,
    "contract_type_id"=>1,
    "filters"=>[{"id"=>2}],
    "eligibility"=>"uncertain"},
   {"id"=>3,
    "name"=>"Aide aux habitants en QPV adultes",
    "slug"=>"aide-aux-habitants-en-qpv-adultes",
    "short_description"=>"",
    "ordre_affichage"=>3,
    "contract_type_id"=>2,
    "filters"=>[{"id"=>2}, {"id"=>1}, {"id"=>4}],
    "eligibility"=>"uncertain"}],
 :flat_all_ineligible=>
  [{"id"=>1,
    "name"=>"Aide au bénéficiaire du RSA",
    "slug"=>"aide-au-beneficiaire-du-rsa",
    "short_description"=>"",
    "ordre_affichage"=>2,
    "contract_type_id"=>1,
    "filters"=>[{"id"=>3}],
    "eligibility"=>"ineligible"},
   {"id"=>7,
    "name"=>"Aides aux bénéficiaires du RSA et adultes",
    "slug"=>"aides-aux-beneficiaires-du-rsa-et-adultes",
    "short_description"=>"",
    "ordre_affichage"=>99,
    "contract_type_id"=>2,
    "filters"=>[{"id"=>1}, {"id"=>3}],
    "eligibility"=>"ineligible"}],
 :flat_all_contract=>
  [{"id"=>1,
    "name"=>"Aide simple",
    "description"=>"Un aide simple, sans règle composite",
    "ordre_affichage"=>50,
    "icon"=>"",
    "slug"=>"aide-simple",
    "category"=>"simple",
    "business_id"=>"aide-simple"},
   {"id"=>2,
    "name"=>"Aide composite",
    "description"=>"Des aides consitituées de règles complexes",
    "ordre_affichage"=>10,
    "icon"=>"",
    "slug"=>"aide-composite",
    "category"=>"composite",
    "business_id"=>"aide-composite"}],
 :flat_all_filter=>
  [{"id"=>1, "name"=>"adulte", "description"=>"Ne concerne que les adultes"},
   {"id"=>3, "name"=>"argent", "description"=>"Les aides liées à l'argent"},
   {"id"=>2,
    "name"=>"zône prioritaire",
    "description"=>
     "Je cherche une aide car je suis en zone prioritaire d'habitation"},
   {"id"=>4,
    "name"=>"special",
    "description"=>"Filtre marqué \"spécial\"..."}],
 :asker=>
  {"v_handicap"=>"oui",
   "v_spectacle"=>"non",
   "v_diplome"=>"niveau_3",
   "v_category"=>"cat_12345",
   "v_duree_d_inscription"=>"plus_d_un_an",
   "v_allocation_value_min"=>"424",
   "v_allocation_type"=>"ASS_AER_ATA_APS_AS-FNE",
   "v_qpv"=>nil,
   "v_zrr"=>nil,
   "v_age"=>"22",
   "v_location_label"=>nil,
   "v_location_route"=>nil,
   "v_location_city"=>nil,
   "v_location_country"=>nil,
   "v_location_zipcode"=>nil,
   "v_location_citycode"=>nil,
   "v_location_street_number"=>nil,
   "v_location_state"=>nil}}
  end

end
