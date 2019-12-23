require "google/apis/analyticsreporting_v4"
require "csv"

module Admin
  class PagesController < Admin::ApplicationController
    def _all_explicitations
      JSON.parse(Explicitation.all.to_json(:only => [:id, :value_eligible, :operator_kind, :template], :include => { variable: { only: [:name] } })).map { |e| e["variable_name"] = e["variable"]["name"]; e.delete("variable"); e }
    end

    def _all_operator_kinds
      ListOperatorKind.new.call
    end

    def _all_variables
      JSON.parse(Variable.all.to_json(:only => [:id, :name, :variable_kind, :elements, :elements_translation, :is_visible, :name_translation]))
    end

    def get_delete_trace
    end

    def post_delete_trace
      Trace.destroy_all
    end

    # load reinit
    def get_reinit
    end

    def post_reinit
      slug = _slug_data
      a = Aid.find_by(slug: slug)
      if a
        a.rule = nil
        a.save
        message = "👍👍👍Le champ d'application de l'aide \"#{a.name}\" a été réinitialisé"
      else
        message = "⚠️⚠️⚠️échec : aucune aide pour le slug #{slug}"
      end
      render json: {
        message: message,
        status: "ok",
      }
    end

    def _slug_data
      params.extract!(:slug_data).permit(:slug_data).to_h["slug_data"]
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

    # refdata
    def get_r7_data
    end

    def get_r7_info
      target_object = params[:target_object]
      target_id = params[:target_id]
      # obj = Object.const_set( params[:target_object].capitalize, Class.new)
      a = Rule if target_object == "rule"
      res = a.find_by(id: target_id)
      render json: {
        actual_object: res
      }
    end

    def post_r7_data
      r = Rule.new(
        name: "r_fake_age_" + rand(36**8).to_s(36),
        kind: "simple",
        variable_id: 1,
        operator_kind: "more_than",
        description: "age...",
        value_eligible: "42"
      )
      r.save
      render json: {
        rule_id: r.id
      }
    end

    # transfer anything
    def get_transfer_descr
    end

    def post_transfer_descr
      # Calculate status on every single field
      Aid.all.each { |aid| aid.update_status }
      render json: {
        status: "ok",
      }
    end
  end
end
