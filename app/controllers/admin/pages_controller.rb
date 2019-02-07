require 'google/apis/analyticsreporting_v4'
require 'csv'    

module Admin
  class PagesController < Admin::ApplicationController

    # load zrr
    def zrr
    end
    def load_zrr
      deleted_zrrs_cache = Rails.cache.delete("zrrs")
      Zrr.create unless Zrr.first
      z = Zrr.first
      z.value = _get_csv_data
      z.save
      render json: {
        deleted_zrrs_cache: deleted_zrrs_cache,
        status: "ok"
      }
    end

    # cache
    def cache
    end
    def expire_json_objects
      ExpireCache.call
      render json: {
        status: "ok"
      }
    end

    #stats
    def stats
    end
    def load_stats
      csv = CSV.parse(_get_csv_data, {headers: true})
      json_data = _csv_to_json(csv)
      _save_stat_of("ga", json_data)
    end
    def load_stats_from_pe
      csv = CSV.parse(_get_csv_data, {headers: true})
      csv.delete("Période")
      json_data = _csv_to_json(csv)
      _save_stat_of("ga_pe", json_data)      
    end
    def load_advisors_stats
      csv = CSV.parse(_get_csv_data, {headers: true})
      csv.delete("Source URL")
      json_data = _csv_to_json(csv)
      _save_stat_of("hj_ad", json_data)   
    end
    def _get_csv_data
      params.extract!(:csv_data).permit(:csv_data).to_h["csv_data"]
    end
    def _save_stat_of(prop, value)
      Stat.create unless Stat.first
      s = Stat.first
      s[prop] = value
      s.save
    end
    def _csv_to_json(csv)
      csv_hash = csv.map(&:to_h)
      root_hash = {}
      root_hash["json_data"] = csv_hash
      root_hash
    end

    # refdata
    def loadrefdata
    end
    def load_ref_data
      Rails.application.load_seed
    end


  end
end
