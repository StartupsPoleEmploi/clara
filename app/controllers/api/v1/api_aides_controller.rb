module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user

      def eligible
        asker = process_asker(english_asker_attr)
        render json: eligible_aids_for(asker)        
      end

      def ineligible
        asker = process_asker(english_asker_attr)
        render json: ineligible_aids_for(asker)        
      end

      def uncertain
        asker = process_asker(english_asker_attr)
        render json: uncertain_aids_for(asker)        
      end

      def english_asker_attr
        params.permit(:disabled, :harki, :ex_invict, :international_protection, :diploma, :category, :inscription_period, :monthly_allocation_value, :allocation_type, :age, :location_street_number, :location_label, :location_citycode).to_h
      end

      private

      def process_asker(given_asker_attr)
        asker = TranslateAskerService.new(given_asker_attr).to_french
        RehydrateAddressService.get_instance.from_citycode!(asker)
      end

      def eligible_aids_for(asker)
        SerializeResultsService.get_instance.jsonify_eligible(asker)
      end

      def ineligible_aids_for(asker)
        SerializeResultsService.get_instance.jsonify_ineligible(asker)
      end

      def uncertain_aids_for(asker)
        SerializeResultsService.get_instance.jsonify_uncertain(asker)
      end

    end
  end
end
