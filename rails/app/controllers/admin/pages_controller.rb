require "google/apis/analyticsreporting_v4"
require "csv"

module Admin
  class PagesController < Admin::ApplicationController

    before_action :require_superadmin, except: [:get_hidden_admin, :get_cache, :post_cache]

    def get_relink
      res = [{:url=>"http://www.wimoov.org/", :problem=>301, :new_url=>"https://www.wimoov.org/"},
             {:url=>"http://www.garages-solidaires.fr", :problem=>301, :new_url=>"https://www.garages-solidaires.fr/"},
             {:url=>"https://mobiliz.groupe.renault.com/",
              :problem=>301,
              :new_url=>"https://mobilize.groupe.renault.com"},
             {:url=>"http://www.fastt.org/", :problem=>301, :new_url=>"https://www.fastt.org/"},
             {:url=>"https://www.linkedin.com/company/google-atelier-num%C3%A9rique-montpellier/?viewAsMember=true",
              :problem=>999,
              :new_url=>""},
             {:url=>"http://europass.cedefop.europa.eu/sites/default/files/cefr-fr.pdf",
              :problem=>301,
              :new_url=>"https://europass.cedefop.europa.eu/sites/default/files/cefr-fr.pdf"},
             {:url=>"http://www.moncompteformation.gouv.fr/",
              :problem=>301,
              :new_url=>"https://www.moncompteformation.gouv.fr/"},
             {:url=>"https://travail-emploi.gouv.fr/emploi/accompagnement-des-mutations-economiques/activite-partielle",
              :problem=>302,
              :new_url=>
               "https://travail-emploi.gouv.fr/le-ministere-en-action/coronavirus-covid-19/proteger-les-travailleurs-les-emplois-les-savoir-faire-et-les-competences/proteger-les-emplois/chomage-partiel-activite-partielle/article/fiche-activite-partielle-chomage-partiel"}
     ]

      render locals: {
        broken_links: res
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
