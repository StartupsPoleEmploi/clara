module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user

      def index
        if current_user
          asker = Asker.new(asker_params)
          p asker.inspect
          p '-----------------------------------------------------------'
          result = SerializeResultsService.new(asker).go
          result.delete :asker
          result[:all_eligible] = result.delete :flat_all_eligible
          result[:all_uncertain] = result.delete :flat_all_uncertain
          result[:all_ineligible] = result.delete :flat_all_ineligible

          format_bunch_of_eligies(result[:all_eligible])
          format_bunch_of_eligies(result[:all_uncertain])
          format_bunch_of_eligies(result[:all_ineligible])

          render json: result.to_json
        else
          render json: {'nothing'  => 'found'}.to_json
        end
      end

      def format_bunch_of_eligies(hash_of_eligies)
        hash_of_eligies.each do |e|  
          e.delete "contract_type_icon"
          e.delete "contract_type_id"
          e.delete "how_much"
          e.delete "how_and_when"
          e.delete "limitations"
          e.delete "additionnal_conditions"
          e.delete "what"
          e.delete "updated_at"
          e.delete "created_at"
          e.delete "archived_at"
          e.delete "last_update"
          e.delete "contract_type_order"
        end
      end

      def asker_params
        params.permit(:v_handicap, :v_harki, :v_detenu, :v_protection_internationale, :v_diplome, :v_category, :v_duree_d_inscription, :v_allocation_value_min, :v_allocation_type, :v_location_label, :v_qpv, :v_zrr, :v_age, :v_location_citycode, :v_location_country, :v_location_label, :v_location_route, :v_location_state, :v_location_street_number, :v_location_zipcode).to_h
      end


    end
  end
end
