require 'rails_helper'
require 'spec_helper'

describe 'Aides index partial' do 

    context 'Nominal' do
      it 'Renders a correct title', type: :view do
        #given
        #when
        _fake_request(build_req(aides_path))
        locals = nominal_locals
        locals["skip_pagination"] = true
        render partial: "shared/aides_index.haml", locals: locals
        #then
        expect(rendered).to have_css(".c-result-all-title")

      end
    end

    def build_req(path, for_id=nil)
      OpenStruct.new(
        {
          request: OpenStruct.new({request_method: 'GET', fullpath: path, path: path})
        }
      )
    end

    def _fake_request(req)
      stubbed_request = class_double("StubRequest").as_stubbed_const
      allow(stubbed_request).to receive(:call).and_return(req)
      stubbed_request
    end


    def nominal_locals
      {"aids"=>
        [{"id"=>22,
          "name"=>"Aide à la mobilité Agefiph",
          "slug"=>"aide-a-la-mobilite-agefiph",
          "short_description"=>
           "Aide au financement de dépenses liées au déplacement pour les travailleurs handicapés (aménagement d'un véhicule adapté, aide ponctuelle aux trajets, ...)",
          "rule_id"=>14,
          "ordre_affichage"=>7,
          "contract_type_id"=>1,
          "filters"=>[{"id"=>2, "slug"=>"se-deplacer"}],
          "custom_filters"=>[],
          "need_filters"=>[]},
         {"id"=>30,
          "name"=>"Aide à la recherche du premier emploi (ARPE) ",
          "slug"=>"arpe-aide-a-la-recherche-du-premier-emploi",
          "short_description"=>
           "Aide à la recherche du premier emploi, versée aux jeunes diplômés boursiers",
          "rule_id"=>76,
          "ordre_affichage"=>43,
          "contract_type_id"=>6,
          "filters"=>[],
          "custom_filters"=>[],
          "need_filters"=>[]},
         {"id"=>36,
          "name"=>"Contrat d'apprentissage",
          "slug"=>"contrat-d-apprentissage",
          "short_description"=>
           "Dispositif de formation initiale associant formation pratique en entreprise et enseignement théorique",
          "rule_id"=>97,
          "ordre_affichage"=>20,
          "contract_type_id"=>7,
          "filters"=>
           [{"id"=>9, "slug"=>"travailler-en-alternance"},
            {"id"=>11, "slug"=>"aides-employeurs"},
            {"id"=>10, "slug"=>"se-former-valoriser-ses-competences"}],
          "custom_filters"=>[],
          "need_filters"=>[]},
         {"id"=>44,
          "name"=>"Autres aides nationales pour la mobilité",
          "slug"=>"autres-aides-nationales-pour-la-mobilite",
          "short_description"=>
           "Aides au déplacement, à l'hébergement, à la garde d'enfant, réparation de véhicules, habillement, ...",
          "rule_id"=>104,
          "ordre_affichage"=>8,
          "contract_type_id"=>1,
          "filters"=>
           [{"id"=>3, "slug"=>"garder-enfant"},
            {"id"=>4, "slug"=>"accompagne-recherche-emploi"},
            {"id"=>2, "slug"=>"se-deplacer"}],
          "custom_filters"=>[],
          "need_filters"=>[]},
         {"id"=>49,
          "name"=>"Validation des acquis de l'expérience (VAE)",
          "slug"=>"vae-validation-des-acquis-de-l-experience",
          "short_description"=>
           "Dispositif permettant d'obtenir un diplôme reconnu grâce à son expérience professionnelle",
          "rule_id"=>104,
          "ordre_affichage"=>71,
          "contract_type_id"=>8,
          "filters"=>[{"id"=>10, "slug"=>"se-former-valoriser-ses-competences"}],
          "custom_filters"=>[],
          "need_filters"=>[]}],
        "total_nb"=>14}
    end

end
