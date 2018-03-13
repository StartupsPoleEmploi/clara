module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user

      def eligible
        asker = TranslateAskerService.new(english_asker).to_french
        result = SerializeResultsService.new(asker).jsonify_eligible
        render json: result        
      end

      def ineligible
        asker = TranslateAskerService.new(english_asker).to_french
        result = SerializeResultsService.new(asker).jsonify_ineligible
        render json: result        
      end

      def uncertain
        asker = TranslateAskerService.new(english_asker).to_french
        result = SerializeResultsService.new(asker).jsonify_uncertain
        render json: result        
      end

      def english_asker
        params.permit(:disabled, :harki, :ex_invict, :international_protection, :diploma, :category, :inscription_period, :monthly_allocation_value, :allocation_type, :age).to_h
      end

    end
  end
end
