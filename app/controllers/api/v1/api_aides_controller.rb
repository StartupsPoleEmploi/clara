module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user

      def detail
        theaid = Aid.first
        render json: {aid: processed_aid_attr}
      end

      def eligible
        render json: eligible_aids_for(processed_asker)        
      end

      def ineligible
        render json: ineligible_aids_for(processed_asker)        
      end

      def uncertain
        render json: uncertain_aids_for(processed_asker)        
      end

      def slug_param
        (params.permit(:aid_slug).to_h)[:aid_slug]
      end

      def english_asker_params
        params.permit(:disabled, :harki, :ex_invict, :international_protection, :diploma, :category, :inscription_period, :monthly_allocation_value, :allocation_type, :age, :location_street_number, :location_route, :location_citycode).to_h
      end

      private

      def processed_aid_attr
        res = {}
        found = Aid.find_by(slug: slug_param)
        res = found.attributes if found
        res
      end

      def processed_asker
        asker = TranslateAskerService.new(english_asker_params).to_french
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
