require 'google/apis/analyticsreporting_v4'
require 'csv'    

module Admin
  class PagesController < Admin::ApplicationController

    def rule_creation
    end
    def post_rule_creation
    end

    # geo
    def get_geo
    end

    def post_geo
    end



    def get_delete_trace
    end
    def post_delete_trace
      Trace.destroy_all
    end

    # load zrr
    def get_zrr
    end
    def post_zrr
      deleted_zrrs_cache = Rails.cache.delete("zrrs")
      Zrr.create unless Zrr.first
      z = Zrr.first
      z.value = _csv_data
      z.save
      render json: {
        deleted_zrrs_cache: deleted_zrrs_cache,
        status: "ok"
      }
    end

    # cache
    def get_cache
    end
    def post_cache
      ExpireCache.new.call
      render json: {
        status: "ok"
      }
    end

    # refdata
    def get_ref_data
    end
    def post_ref_data
      Rails.application.load_seed
    end


    # transfer anything
    def get_transfer_descr
    end
    def post_transfer_descr
      Filter.all.each do |filter|
        filter.name = filter.description
        filter.save
      end
      render json: {
        status: "ok"
      }
    end


  end
end
