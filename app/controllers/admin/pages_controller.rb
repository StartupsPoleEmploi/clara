require 'google/apis/analyticsreporting_v4'
require 'csv'    

module Admin
  class PagesController < Admin::ApplicationController

    def stats
    end

    def rename
    end

    def archive
    end

    def loadrefdata
    end

    def cache
    end

    def zrr
    end

    def load_zrr
      Zrr.create unless Zrr.first
      z = Zrr.first
      z.value = _get_csv_data
      z.save
      render json: {
        status: "ok"
      }
    end


    def expire_welcome_page
      expire_page controller: "/welcome", action: "index"
    end

    def expire_json_objects
      activated_models_deleted     = Rails.cache.delete("activated_models")
      nb_of_detailed_aids_deleted  = HashService.new.reject_keys_that_starts_with!(Rails.cache, "aids:")
      all_filters_deleted          = Rails.cache.delete("filters")
      regenerated_activated_models = ActivatedModelsService.instance.regenerate.empty?
        
      render json: {
        activated_models_deleted: activated_models_deleted,
        nb_of_detailed_aids_deleted: nb_of_detailed_aids_deleted,
        all_filters_deleted: all_filters_deleted,
        regenerated_activated_models: regenerated_activated_models,
      }
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

    def load_ref_data
      Rails.application.load_seed
    end

    def archive_all_aids
      d  = Date.parse("2014-1-17")
      Aid.all.update_all("archived_at = '#{d}'")
      return
    end

    def unarchive_all_aids
      Aid.all.update_all("archived_at = null")
      return
    end

    def rename_eligible_value
      a = params.extract!(:initial_value).permit(:initial_value).to_h
      b = params.extract!(:final_value).permit(:final_value).to_h
      initial_value = a[:initial_value]      
      final_value = b[:final_value]
      CustomRuleCheck.where(result: initial_value).update_all("result = '#{final_value}'")
    end


  end
end
