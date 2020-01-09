require "google/apis/analyticsreporting_v4"
require "csv"

module Admin
  class PagesController < Admin::ApplicationController

    before_action :require_superadmin, except: [:get_hidden_admin, :get_cache, :post_cache]

    def get_delete_trace
    end

    def post_delete_trace
      Trace.destroy_all
    end

    # load reinit
    def get_reinit
    end

    def post_reinit
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
        status: "ok",
      }
    end

    def _csv_data
      params.extract!(:csv_data).permit(:csv_data).to_h["csv_data"]
    end

    # cache
    def get_cache
    end

    def post_cache
      ExpireCache.new.call
      render json: {
        status: "ok",
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
    end
  end
end
