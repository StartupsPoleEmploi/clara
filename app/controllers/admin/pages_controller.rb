require 'google/apis/analyticsreporting_v4'
require 'csv'    

module Admin
  class PagesController < Admin::ApplicationController

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
      Variable.find_by(name: "v_location_city").update(variable_kind: "string")
      Variable.find_by(name: "v_location_route").update(variable_kind: "string")
      Variable.find_by(name: "v_location_label").update(variable_kind: "string")
      Variable.find_by(name: "v_location_street_number").update(variable_kind: "string")
      Variable.find_by(name: "v_location_country").update(variable_kind: "string")
      Variable.find_by(name: "v_category").update(variable_kind: "selectionnable")
      Variable.find_by(name: "v_diplome").update(variable_kind: "selectionnable")
      Variable.find_by(name: "v_allocation_value_min").update(variable_kind: "integer")
      Variable.find_by(name: "v_qpv").update(variable_kind: "selectionnable")
      Variable.find_by(name: "v_handicap").update(variable_kind: "selectionnable")
      Variable.find_by(name: "v_autres").update(variable_kind: "selectionnable")
      Variable.find_by(name: "v_protection_internationale").update(variable_kind: "selectionnable")
      Variable.find_by(name: "v_detenu").update(variable_kind: "selectionnable")
      Variable.find_by(name: "v_harki").update(variable_kind: "selectionnable")
      Variable.find_by(name: "v_location_citycode").update(variable_kind: "string")
      Variable.find_by(name: "v_location_state").update(variable_kind: "string")
      Variable.find_by(name: "v_location_zipcode").update(variable_kind: "string")
      Variable.find_by(name: "v_spectacle").update(variable_kind: "selectionnable")
      Variable.find_by(name: "v_allocation_type").update(variable_kind: "selectionnable")
      Variable.find_by(name: "v_zrr").update(variable_kind: "selectionnable")
      Variable.find_by(name: "v_cadre").update(variable_kind: "selectionnable")
      Variable.find_by(name: "v_age").update(variable_kind: "integer")
      Variable.find_by(name: "v_duree_d_inscription").update(variable_kind: "selectionnable")
    end


  end
end
