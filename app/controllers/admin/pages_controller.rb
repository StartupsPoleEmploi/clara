require 'google/apis/analyticsreporting_v4'
require 'csv'    

module Admin
  class PagesController < Admin::ApplicationController

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
      ExpireCache.call
      render json: {
        status: "ok"
      }
    end

    #stats
    def get_stats
    end
    def post_stats
      csv = CSV.parse(_csv_data, {headers: true})
      json_data = _csv_to_json(csv)
      _save_stat_of("ga", json_data)
    end
    def post_stats_from_pe
      csv = CSV.parse(_csv_data, {headers: true})
      csv.delete("Période")
      json_data = _csv_to_json(csv)
      _save_stat_of("ga_pe", json_data)      
    end
    def post_stats_advisors
      csv = CSV.parse(_csv_data, {headers: true})
      csv.delete("Source URL")
      json_data = _csv_to_json(csv)
      _save_stat_of("hj_ad", json_data)   
    end
    def _csv_data
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
    def get_ref_data
    end
    def post_ref_data
      Rails.application.load_seed
    end


    # transfer anything
    def get_transfer_descr
    end
    def post_transfer_descr
      simuls = {} 
      Rule.all.each do |rule|
        new_simulated = CalculateRuleSimulated.new.call(rule)
        simuls[new_simulated] = [] if simuls[new_simulated] == nil
        simuls[new_simulated] << rule.id
      end
      Rule.where(id: simuls["errored_simulation"]).update_all(simulated: "errored_simulation")
      Rule.where(id: simuls["ok"]).update_all(simulated: "ok")
      Rule.where(id: simuls["missing_simulation"]).update_all(simulated: "missing_simulation")
      Rule.where(id: simuls["missing_eligible"]).update_all(simulated: "missing_eligible")
      Rule.where(id: simuls["missing_ineligible"]).update_all(simulated: "missing_ineligible")
      render json: {
        status: "ok"
      }
    end


  end
end
