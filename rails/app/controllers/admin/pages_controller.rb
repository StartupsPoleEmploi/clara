require "google/apis/analyticsreporting_v4"
require "csv"

module Admin
  class PagesController < Admin::ApplicationController

    before_action :require_superadmin, except: [:get_hidden_admin, :get_cache, :post_cache]

    def get_relink
      res = [{:url=>"http://www.wimoov.org/", :problem=>301, :new_url=>"https://www.wimoov.org/"},
  {:url=>"https://www.agefiph.fr/Les-services-et-aides-financieres-de-l-Agefiph/Aide-protheses-auditives",
  :problem=>301,
  :new_url=>"https://www.agefiph.fr/aides-handicap/aide-protheses-auditives",
  :aids=>["aide-a-l-achat-de-protheses-auditives"]},
 {:url=>"http://www.pole-emploi.fr/accueil/",
  :problem=>301,
  :new_url=>"https://www.pole-emploi.fr/accueil/",
  :aids=>
   ["arce-aide-a-la-reprise-ou-a-la-creation-d-entreprise",
    "eccp",
    "dispositif-d-interessement-a-la-reprise-d-activite",
    "programme-reactivate",
    "aide-a-la-mobilite-frais-de-deplacement-bon-de-transport",
    "accompagnement-apec",
    "contrat-de-professionnalisation",
    "aide-agefiph-au-contrat-d-apprentissage",
    "aide-a-la-mobilite-agefiph",
    "activ-crea",
    "aide-agefiph-a-la-creation-et-reprise-d-entreprise",
    "pmsmp",
    "aides-a-la-remuneration-pendant-une-formation",
    "aide-a-la-mobilite-frais-d-hebergement",
    "aide-incitative-a-la-reprise-d-emploi"]}
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
