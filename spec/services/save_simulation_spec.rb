require 'rails_helper'

describe SaveSimulation do

  describe '.call' do
    it 'Nominal : render json "ok" and modify status of underlying rule' do
      # given
      r = create(:rule, :be_an_adult)
      expect(r.simulated).to eq("missing_simulation")
      # when
      res = SaveSimulation.new.call(r.id, _asker_params, _simulation_params)
      # then
      expect(res).to eq({:json=>["ok"], :status=>:created})
      new_status = Rule.find(r.id).attributes["simulated"]
      expect(new_status).to eq("missing_eligible")
    end

    def _simulation_params
      {result: "ineligible", name: "aah"}
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
