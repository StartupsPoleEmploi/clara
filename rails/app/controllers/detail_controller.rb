class DetailController < ApplicationController

  after_action :save_asker

  def show
    redirection_url = redirection_table[request.path]
    if redirection_url.present?
      redirect_to redirection_url
    else
      @aid = Aid.activated.friendly.find_by(slug: params[:id])
      if (@aid == nil && current_user != nil)
        @aid = Aid.find_by(slug: params[:id])
      end
      if has_active_user
        existing = Rails.cache.read(params[:for_id])
        if (existing) # already in the cache, we dont have to calculate anything
          @asker = Asker.new(existing[:asker])
        else
          @asker = TranslateB64AskerService.new.from_b64(params[:for_id])
          @asker = HydrateAsker.new.call(@asker.attributes)
        end
        @loaded = DetailService.new(@aid).hashified_eligibility_and_rules(@asker)
        RecordRegister.new.call(session, @asker, params[:id])
      else
        @loaded = DetailService.new(@aid).hashified_aid
      end
      raise SecurityError if @loaded[:aid] == nil
    end
  end

  def post_feedback
    extractor = ExtractParam.new(params)
    new_feedback = Feedback.new(
      content: extractor.call("content"),
      positive: extractor.call("positive"),
      url_of_detail: extractor.call("url_of_detail")
    )
    new_feedback.save
    render json: {
      status: "ok"
    }
  end

  def has_active_user
    !!params[:for_id]
  end

  def redirection_table
  {
    "/aides/detail/aide-au-financement-du-permis-b-pour-les-apprentis" => "https://mes-aides.pole-emploi.fr/etat/apprentis-majeurs",
    "/aides/detail/aides-a-la-mobilite-dans-la-region-hauts-de-france" => "https://mes-aides.pole-emploi.fr/region-hauts-de-france/aide-regionale-aide-au-permis-de-conduire-pour-l-insertion-professionnelle-des-jeunes-",
    "/aides/detail/pret-mobilite-de-l-adie" => "https://mes-aides.pole-emploi.fr/l-adie-et-l-etat/pret-mobilite-de-l-adie",
    "/aides/detail/aide-au-parcours-vers-l-emploi" => "https://mes-aides.pole-emploi.fr/agefiph/aide-a-la-formation-dans-le-cadre-du-parcours-vers-l-emploi",
    "/aides/detail/aide-a-la-mobilite-agefiph" => "https://mes-aides.pole-emploi.fr/agefiph/aide-a-la-formation-dans-le-cadre-du-parcours-vers-l-emploi",
    "/aides/detail/aide-a-la-mobilite-frais-de-deplacement-bon-de-transport" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/aides-action-logement" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/aide-a-la-mobilite-frais-de-deplacement-bon-de-reservation" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/aide-a-la-mobilite-frais-de-deplacement" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/aide-a-la-mobilite-frais-d-hebergement" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/plateforme-mobilite-montauban-services" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite/annuaires/plateformes-mobilite",
    "/aides/detail/aide-a-la-mobilite-frais-de-repas" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/rezo-pouce" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/billet-pass-emploi" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/illico-solidaire" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/coup-de-pouce" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/programme-solidaire-mana-ara" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/mobilize" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/aide-au-demenagement-pour-les-artistes-ou-technicien-ne-s-du-spectacle" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/aide-a-la-mobilite-professionnelle-des-artistes-et-technicien-ne-s-du-spectacle" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/aide-aux-depenses-quotidiennes-pendant-une-formation-pour-les-artistes-et-technicien-ne-s-du-spectacle" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/bon-tarif-reduit-recherche-emploi-bourgogne-franche-comte" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite",
    "/aides/detail/plateforme-mobilite-mayenne" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite/annuaires/plateformes-mobilite",
    "/aides/detail/carte-mobi-pays-de-la-loire" => "https://mes-aides.pole-emploi.fr/transport-et-mobilite"
  }
  end

end
