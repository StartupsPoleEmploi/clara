require 'rails_helper'
require 'spec_helper'

describe AidesIndex do

  describe '.has_user' do
    
    it 'Can return true if for_id query param exists' do
      #given
      sut = AidesIndex.new(build_url(for_id: "abcd"), nominal_locals)
      #when
      res = sut.has_user
      #then
      expect(res).to eq(true)
    end

    it 'Can return false if for_id query param DO NOT exists' do
      #given
      sut = AidesIndex.new(build_url({}), nominal_locals)
      #when
      res = sut.has_user
      #then
      expect(res).to eq(false)
    end

    it 'Description has a value if user is here' do
      #given
      sut = AidesIndex.new(build_url(for_id: "abcd"), nominal_locals)
      #when
      res = sut.description
      #then
      expect(res).to eq("Vos résultats")
    end

    it 'Description has another value if user is NOT here' do
      #given
      sut = AidesIndex.new(build_url({}), nominal_locals)
      #when
      res = sut.description
      #then
      expect(res).to eq("Découvrez toutes les aides et mesures de retour à l'emploi")
    end

    it 'Title has a value if user is here' do
      #given
      sut = AidesIndex.new(build_url(for_id: "abcd"), nominal_locals)
      #when
      res = sut.title
      #then
      expect(res).to eq("Vos résultats")
    end

    it 'Title has another value if user is not here' do
      #given
      sut = AidesIndex.new(build_url({}), nominal_locals)
      #when
      res = sut.title
      #then
      expect(res).to eq("Découvrez toutes les aides et mesures de retour à l'emploi")
    end

    it 'Title includes page 2/3 if page param is 2 and total_nb of page is 14' do
      #given
      locals = nominal_locals
      locals["total_nb"] = 14
      sut = AidesIndex.new(build_url({usearch:"mobilite", page:"2"}), locals)
      #when
      res = sut.title
      #then
      expect(res).to eq("Résultat de recherche – 14 aides et mesures sont disponibles - page 2 sur 3")
    end

    it 'Title includes page 2/2 if page param is 2 and total_nb of page is 10' do
      #given
      locals = nominal_locals
      locals["total_nb"] = 10
      sut = AidesIndex.new(build_url({usearch:"mobilite", page:"2"}), locals)
      #when
      res = sut.title
      #then
      expect(res).to eq("Résultat de recherche – 10 aides et mesures sont disponibles - page 2 sur 2")
    end

    it 'Title includes page 1/1 if page param is 1 and total_nb of page is 1' do
      #given
      locals = nominal_locals
      locals["total_nb"] = 1
      sut = AidesIndex.new(build_url({usearch:"mobilite", page:"1"}), locals)
      #when
      res = sut.title
      #then
      expect(res).to eq("foo")
    end

    def build_url(h_params)
      query_h = h_params.with_indifferent_access
      OpenStruct.new(
        {
          request: OpenStruct.new({query_parameters: query_h})
        }
      )
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

end
