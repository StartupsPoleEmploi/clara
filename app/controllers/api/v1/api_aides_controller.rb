module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user

      # def index
      #   asker = TranslateAskerService.new(english_asker).to_french
      #   result = SerializeResultsService.new(asker).jsonify
      #   render json: result
      # end

      def eligible
        asker = TranslateAskerService.new(english_asker).to_french
        result = SerializeResultsService.new(asker).jsonify_eligible
        render json: result        
      end

      def ineligible
        
      end

      def uncertain
        
      end

      def english_asker
        params.permit(:disabled, :harki, :ex_invict, :international_protection, :diploma, :category, :inscrition_period, :monthly_allocation, :allocation_type, :age).to_h
      end

    end
  end
end
