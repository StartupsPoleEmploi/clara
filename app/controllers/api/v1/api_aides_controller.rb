module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user

      def eligible
        asker = process_asker(english_asker)
        render json: eligible_aids_for(asker)        
      end

      def ineligible
        asker = process_asker(english_asker)
        render json: ineligible_aids_for(asker)        
      end

      def uncertain
        asker = process_asker(english_asker)
        render json: uncertain_aids_for(asker)        
      end

      def english_asker
        params.permit(:disabled, :harki, :ex_invict, :international_protection, :diploma, :category, :inscription_period, :monthly_allocation_value, :allocation_type, :age, :location_street_number, :location_label, :location_citycode).to_h
      end

      private

      def process_asker(given_asker)
        asker = TranslateAskerService.new(given_asker).to_french
        RehydrateAddressService.new.from_citycode!(asker)
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
