require "uri"

module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user, except: [:ping]

      # /api/v1/aids/ping(.:format)
      def ping
        track_call("/api/v1/ping", request.remote_ip)
        render json: {status: "ok"}.to_json, status: 200
      end

      # /api/v1/filters(.:format)
      def filters
        track_call("/api/v1/filters", current_user.email)
        whitelisted_filters = whitelist_filters(JSON.parse(Rails.cache.fetch("filters") {Filter.all.to_json(:only => [ :id, :slug, :name, :description ])}))
        res = {filters: whitelisted_filters}
        render json: remove_ids!(not_nullify(res)).to_json
      end

      # /api/v1/level3_filters(.:format)
      def level3_filters
        track_call("/api/v1/level3_filters", current_user.email)
        all_filters = JSON.parse(Rails.cache.fetch("level3_filters") {_build_level3_filter_grape.to_json})
        res = {level3_filters: all_filters}
        render json: remove_ids!(not_nullify(res)).to_json
      end
      def _build_level3_filter_grape
        Level3Filter.all.map do |e|  
          {
            slug: e.slug,
            name: e.name,
            description: e.description,
            level2_filter: e.level2_filter ? e.level2_filter.slug : nil,
            level1_filter: e.level2_filter && e.level2_filter.level1_filter ? e.level2_filter.level1_filter.slug : nil,
          }
        end
      end

      # /api/v1/aids/detail/:aid_slug(.:format)
      def detail
        track_call("/api/v1/aids/detail/:aid_slug", current_user.email)
        found_aid = Rails.cache.fetch("aids[#{slug_param}]") {Aid.find_by(slug: slug_param).to_json}
        if found_aid != "null"
          render json: {aid: remove_ids!(not_nullify(whitelist_one_aid_attr(JSON.parse(found_aid))))}
        else
          render json: {:error => "not-found"}.to_json, status: 404
        end
      end

      # /api/v1/aids/eligible(.:format)
      def eligible
        track_call("/api/v1/aids/eligible", current_user.email)
        api_asker = ApiAskerService.new(english_asker_params).to_api_asker
        api_filters = ApiFilters.new(filters: filters_param)
        api_level3_filters = ApiLevel3Filters.new(filters: level3_filters_param)
        errors_hash = {}
        fill_errors!(errors_hash, api_filters, api_level3_filters, api_asker)
        if !errors_hash.empty?
          render json: errors_hash.to_json, status: 400
        else
          local_asker = params.permit(:random).to_h[:random] == "true" ? CalculateAskerService.new(RandomAskerService.new.go).calculate_zrr! : processed_asker(api_asker)
          render json: {
            asker: not_nullify(reverse_translation_of(local_asker)),
            aids: remove_ids!(not_nullify(eligible_aids_for(local_asker, api_filters.filters, api_level3_filters.filters)))
          }.to_json
        end
      end


      # /api/v1/aids/ineligible(.:format)
      def ineligible
        track_call("/api/v1/aids/ineligible", current_user.email)
        api_asker = ApiAskerService.new(english_asker_params).to_api_asker
        api_filters = ApiFilters.new(filters: filters_param)
        api_level3_filters = ApiLevel3Filters.new(filters: level3_filters_param)
        errors_hash = {}
        fill_errors!(errors_hash, api_filters, api_level3_filters, api_asker)
        if !errors_hash.empty?
          render json: errors_hash.to_json, status: 400
        else
          local_asker = params.permit(:random).to_h[:random] == "true" ? CalculateAskerService.new(RandomAskerService.new.go).calculate_zrr! : processed_asker(api_asker)
          render json: {
            asker: not_nullify(reverse_translation_of(local_asker)),
            aids: remove_ids!(not_nullify(ineligible_aids_for(local_asker, api_filters.filters, api_level3_filters.filters)))
          }.to_json
        end
      end

      # /api/v1/aids/uncertain(.:format)
      def uncertain
        track_call("/api/v1/aids/uncertain", current_user.email)
        api_asker = ApiAskerService.new(english_asker_params).to_api_asker
        api_filters = ApiFilters.new(filters: filters_param)
        api_level3_filters = ApiLevel3Filters.new(filters: level3_filters_param)
        errors_hash = {}
        fill_errors!(errors_hash, api_filters, api_level3_filters, api_asker)
        if !errors_hash.empty?
          render json: errors_hash.to_json, status: 400
        else
          local_asker = params.permit(:random).to_h[:random] == "true" ? CalculateAskerService.new(RandomAskerService.new.go).calculate_zrr! : processed_asker(api_asker)
          render json: {
            asker: not_nullify(reverse_translation_of(local_asker)),
            aids: remove_ids!(not_nullify(uncertain_aids_for(local_asker, api_filters.filters, api_level3_filters.filters)))
          }.to_json
        end     
      end



      def slug_param
        (params.permit(:aid_slug).to_h)[:aid_slug]
      end

      def english_asker_params
        params.permit(:disabled, :spectacle, :diploma, :category, :inscription_period, :monthly_allocation_value, :allocation_type, :age, :location_street_number, :location_route, :location_citycode).to_h
      end

      def filters_param
        params.permit(:filters).to_h[:filters]
      end
      def level3_filters_param
        params.permit(:level3_filters).to_h[:level3_filters]
      end

      private

      def fill_errors!(errors_hash, api_filters, api_level3_filters, api_asker)
        if !api_level3_filters.valid?
          errors_hash.merge!(api_level3_filters.errors) 
        end
        if !api_filters.valid?
          errors_hash.merge!(api_filters.errors) 
        end
        if !api_asker.valid?
          errors_hash.merge!(process_asker_errors(api_asker.errors)) 
        end
      end

      def reverse_translation_of(api_asker)
        TranslateAskerService.new.from_french(api_asker) 
      end

      def not_nullify(hash_or_array)
        HashService.new.recursive_compact(hash_or_array)
      end

      def remove_ids!(hash_or_array)
        HashService.new.reject_ids!(hash_or_array)
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

      def process_asker_errors(errors)
        h = JSON.parse(errors.to_json) # elegant way to get the full grape without over-engineering
        h.transform_keys{ |key| ApiAskerKeysService.new.asker_hash[key] }
      end

      def processed_asker(api_asker)
        asker = TranslateAskerService.new.to_french(api_asker)
        CalculateAskerService.new(asker).calculate_zrr!
      end

      def eligible_aids_for(asker, filters, level3_filters)
        SerializeResultsService.get_instance.api_eligible(asker, filters, level3_filters)
      end

      def ineligible_aids_for(asker, filters)
        SerializeResultsService.get_instance.api_ineligible(asker, filters, level3_filters)
      end

      def uncertain_aids_for(asker, filters)
        SerializeResultsService.get_instance.api_uncertain(asker, filters, level3_filters)
      end

    end
  end
end
