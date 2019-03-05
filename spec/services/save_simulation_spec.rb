require 'rails_helper'

describe SaveSimulation do

  describe '.call' do
    it 'ok' do
      r = create(:rule, :be_an_adult)
      expect(r.status).to eq("missing_simulation")
      res = SaveSimulation.new.call(r.id.to_s, _asker_params, _simulation_params)
      expect(res).to eq("blabla")
      # expect(r.status).to eq("missing_eligible")
    end

    def _simulation_params
      {"result"=>"ineligible", "name"=>"aah"}
    end

    def _asker_params
      {"v_handicap"=>"",
       "v_spectacle"=>"",
       "v_diplome"=>"",
       "v_cadre"=>"",
       "v_category"=>"",
       "v_duree_d_inscription"=>"",
       "v_allocation_value_min"=>"",
       "v_allocation_type"=>"AAH",
       "v_location_label"=>"",
       "v_qpv"=>"",
       "v_zrr"=>"",
       "v_age"=>"",
       "v_location_city"=>"",
       "v_location_citycode"=>"",
       "v_location_country"=>"",
       "v_location_route"=>"",
       "v_location_state"=>"",
       "v_location_street_number"=>"",
       "v_location_zipcode"=>""}
    end

  end
end
