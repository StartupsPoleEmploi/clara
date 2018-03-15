module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user

      def eligible
        asker = translate(english_asker).to_french
        rehydrate_from_citycode!(asker)
        result = jsonify_eligible_aids_from(asker)
        render json: result        
      end

      def ineligible
        asker = TranslateAskerService.new(english_asker).to_french
        result = SerializeResultsService.get_instance.jsonify_ineligible(asker)
        render json: result        
      end

      def uncertain
        asker = TranslateAskerService.new(english_asker).to_french
        result = SerializeResultsService.get_instance.jsonify_uncertain(asker)
        render json: result        
      end

      def english_asker
        params.permit(:disabled, :harki, :ex_invict, :international_protection, :diploma, :category, :inscription_period, :monthly_allocation_value, :allocation_type, :age, :location_street_number, :location_label, :location_citycode).to_h
      end

      private
      def translate(english_asker)
        TranslateAskerService.new(english_asker)
      end

      def rehydrate_from_citycode!(asker)
        RehydrateAddressService.new.from_citycode!(asker)
      end

      def jsonify_eligible_aids_from(asker)
        SerializeResultsService.get_instance.jsonify_eligible(asker)
      end

    end
  end
end
