require "uri"

module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user

      # /api/v1/filters(.:format)
      def filters
        track_call("/api/v1/aids/filters", current_user.email)
        whitelisted_filters = whitelist_filters(ActivatedModelsService.get_instance.filters)
        render json: {filters: whitelisted_filters}.to_json
      end

      # /api/v1/aids/detail/:aid_slug(.:format)
      def detail
        track_call("/api/v1/aids/detail/:aid_slug", current_user.email)
        aid_attr = whitelist_one_aid_attr(Aid.find_by(slug: slug_param))
        if aid_attr != {} 
          render json: {aid: aid_attr}
        else
          render json: {:error => "not-found"}.to_json, status: 404
        end
      end

      # /api/v1/aids/eligible(.:format)
      def eligible
        track_call("/api/v1/aids/eligible", current_user.email)
        api_asker = ApiAskerService.new(english_asker_params).to_api_asker
        if api_asker.valid?
          asker = processed_asker(api_asker)
          render json: {
            asker: not_nullify(reverse_translation_of(asker)),
            aids: not_nullify(eligible_aids_for(asker))
          }.to_json
        else
           render json: processed_errors(api_asker.errors).to_json, status: 400
        end
      end


      # /api/v1/aids/ineligible(.:format)
      def ineligible
        track_call("/api/v1/aids/ineligible", current_user.email)
        api_asker = ApiAskerService.new(english_asker_params).to_api_asker
        if api_asker.valid?
           render json: jsonify(not_nullify(ineligible_aids_for(processed_asker(api_asker))))
        else
           render json: processed_errors(api_asker.errors).to_json, status: 400
        end       
      end

      # /api/v1/aids/uncertain(.:format)
      def uncertain
        track_call("/api/v1/aids/uncertain", current_user.email)
        api_asker = ApiAskerService.new(english_asker_params).to_api_asker
        if api_asker.valid?
           render json: jsonify(not_nullify(uncertain_aids_for(processed_asker(api_asker))))
        else
           render json: processed_errors(api_asker.errors).to_json, status: 400
        end       
      end

      def slug_param
        (params.permit(:aid_slug).to_h)[:aid_slug]
      end

      def english_asker_params
        params.permit(:disabled, :spectacle, :diploma, :category, :inscription_period, :monthly_allocation_value, :allocation_type, :age, :location_street_number, :location_route, :location_citycode).to_h
      end

      private

      def reverse_translation_of(api_asker)
        TranslateAskerService.new.from_french(api_asker) 
      end

      def not_nullify(hash_or_array)
        HashService.new.recursive_compact(hash_or_array)
      end

      def jsonify(hash_or_array)
        hash_or_array.to_json
      end

      def track_call(endpoint, who)
        TrackCallService.get_instance.for_endpoint(endpoint, who)
      end

      def whitelist_one_aid_attr(aid)
        WhitelistAidService.new.for_a_detailed_aid(aid)
      end

      def whitelist_filters(filters)
        return [] unless filters.is_a?(Array) && !filters.empty?
        filters.map { |filter| WhitelistAidService.new.for_a_filter(filter) }
      end

      def processed_errors(errors)
        h = JSON.parse(errors.to_json) # elegant way to get the full grape without over-engineering
        h.transform_keys{ |key| ApiAskerKeysService.new.asker_hash[key] }
      end

      def processed_asker(api_asker)
        asker = TranslateAskerService.new.to_french(api_asker)
        RehydrateAddressService.get_instance.from_citycode!(asker)
      end

      def eligible_aids_for(asker)
        SerializeResultsService.get_instance.api_eligible(asker)
      end

      def ineligible_aids_for(asker)
        SerializeResultsService.get_instance.api_ineligible(asker)
      end

      def uncertain_aids_for(asker)
        SerializeResultsService.get_instance.api_uncertain(asker)
      end

    end
  end
end
