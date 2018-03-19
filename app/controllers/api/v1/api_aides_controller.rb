require "uri"

module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user

      # /api/v1/aids/detail/:aid_slug(.:format)
      def detail
        track_call("/api/v1/aids/detail/:aid_slug", slug_param)
        aid_attr = whitelist_one_aid_attr(Aid.find_by(slug: slug_param))
        if aid_attr != {} 
          render json: {aid: aid_attr}
        else
          render json: {:error => "not-found"}.to_json, status: 404
        end
      end

      # /api/v1/aids/eligible(.:format)
      def eligible
        track_call("/api/v1/aids/eligible", english_asker_params.to_s)
        render json: eligible_aids_for(processed_asker)        
      end

      # /api/v1/aids/ineligible(.:format)
      def ineligible
        track_call("/api/v1/aids/ineligible", english_asker_params.to_s)
        render json: ineligible_aids_for(processed_asker)        
      end

      # /api/v1/aids/uncertain(.:format)
      def uncertain
        track_call("/api/v1/aids/uncertain", english_asker_params.to_s)
        render json: uncertain_aids_for(processed_asker)        
      end

      def slug_param
        (params.permit(:aid_slug).to_h)[:aid_slug]
      end

      def english_asker_params
        params.permit(:disabled, :harki, :ex_invict, :international_protection, :diploma, :category, :inscription_period, :monthly_allocation_value, :allocation_type, :age, :location_street_number, :location_route, :location_citycode).to_h
      end

      private

      def track_call(endpoint, values="")
        TrackCallService.get_instance.for_endpoint(endpoint, values)
      end

      def whitelist_one_aid_attr(aid)
        WhitelistAidService.new.for_a_detailed_aid(aid)
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
