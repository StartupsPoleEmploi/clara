require "google/apis/analyticsreporting_v4"
require "csv"

module Admin
  class PagesController < Admin::ApplicationController

    before_action :require_superadmin, except: [:get_hidden_admin, :get_cache, :post_cache]

    def post_broken
      DetectBrokenLinksJob.perform_later
      render json: {
        status: "ok, tâche démarée, durée 3 min. environ. Vous pouvez allez voir sous /admin/sidekiq/scheduled.",
      }
    end

    def get_relink

     res = Broken.all.map do |e| 
        h = {}
        h[:url] = e[:url]
        h[:new_url] = e[:new_url]
        h[:aids_slug] = JSON.parse(e[:aids_slug])
        h[:code] = e[:code]
        h
     end

      render locals: {
        broken_links: res.sort_by { |e| e[:aids_slug].size  }
      }
      
    end

    def post_delete_trace
      Trace.destroy_all
      render json: {status: "ok"}
    end

    def get_switch_peconnect
      render locals: {
        is_activated: PeconnectActivation.new.get_value
      }
    end

    def post_switch_peconnect
      PeconnectActivation.new.switch_value
      redirect_to admin_get_switch_peconnect_path
    end

    # load clock
    def get_clock
      first_diff = Clockdiff.first
      unless first_diff
        first_diff = Clockdiff.new(value: 0)
        first_diff.save
      end
      render locals: {
        current_diff_value: first_diff.value
      }
    end

    def post_clock
      current_clockdiff = Clockdiff.first
      current_clockdiff.value = params[:clock_delta].to_i
      current_clockdiff.save
      render locals: {
        current_diff_value: current_clockdiff.value
      }
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
      render json: {status: "ok"}
    end

    # refdata
    def get_ref_data
    end

    def post_ref_data
      Rails.application.load_seed
      render json: {status: "ok"}
    end

    # transfer anything
    def get_transfer_descr
    end

    def post_transfer_descr
      HelloWorldJob.set(wait: 5.seconds).perform_later
      render json: {status: "ok"}
    end
  end
end
