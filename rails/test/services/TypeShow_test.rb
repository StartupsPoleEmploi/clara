require "test_helper"

class TypeShowTest < ActiveSupport::TestCase
  
  test "._hacky_addition_for_ddct nominal" do
    sut = TypeShow.new(
      OpenStruct.new({params: {id: "financement-aide-a-la-formation"}}), 
      nominal_args
    )
    aids = []
    res = sut._hacky_addition_for_ddct(aids)
    assert_equal(42, res)
  end
  
  test ".contract_type Returns the contract_type" do
    sut = TypeShow.new(nil, nominal_args)
    res = sut.contract_type
    assert_equal({:id=>6, :name=>"Appui à l'embauche", :slug=>"appui-a-l-embauche"}, res)
  end
  
  test ".clazz Returns the contract_type's slug" do
    sut = TypeShow.new(nil, nominal_args)
    res = sut.clazz
    assert_equal("c-detail-title--appui-a-l-embauche", res)
  end

  test ".has_line Returns true if there are many lines" do
    sut = TypeShow.new(nil, nominal_args)
    res = sut.has_line
    assert_equal(true, res)
  end

  test ".has_line Returns false if there are 0 line" do
    #given
    args = nominal_args
    args[:aids] = []
    sut = TypeShow.new(nil, args)
    #when
    res = sut.has_line
    #then
    assert_equal(false, res)
  end

  test ".title_of_tab Returns name of contract by default" do
    sut = TypeShow.new(nil, nominal_args)
    res = sut.title_of_tab
    assert_equal("Appui à l'embauche", res)
  end

  test ".title_of_tab Returns Aides à la création for appropriate slug" do
    #given
    args = nominal_args
    args[:contract]["slug"] = 'aide-a-la-creation-ou-reprise-d-entreprise'
    sut = TypeShow.new(nil, args)
    # when
    res = sut.title_of_tab
    # then
    assert_equal("Aides à la création ou reprise d\'entreprise", res)
  end

  test ".title_of_tab Returns 'Aides à la mobilité, au déplacement, garde d\'enfant' for appropriate slug" do
    #given
    args = nominal_args
    args[:contract]["slug"] = 'aide-a-la-mobilite'
    sut = TypeShow.new(nil, args)
    # when
    res = sut.title_of_tab
    # then
    assert_equal("Aides à la mobilité, au déplacement, garde d\'enfant", res)
  end

  test ".title_of_tab Returns 'Aides à l\'alternance' for appropriate slug" do
    #given
    args = nominal_args
    args[:contract]["slug"] = 'contrat-en-alternance'
    sut = TypeShow.new(nil, args)
    # when
    res = sut.title_of_tab
    # then
    assert_equal("Aides à l\'alternance", res)
  end

  test ".title_of_tab Returns 'Aides à l\'orientation' for appropriate slug" do
    #given
    args = nominal_args
    args[:contract]["slug"] = 'aide-a-la-definition-du-projet-professionnel'
    sut = TypeShow.new(nil, args)
    # when
    res = sut.title_of_tab
    # then
    assert_equal("Aides à l\'orientation, la reconversion professionnelle", res)
  end

  test ".line Returns a filtered version" do
    sut = TypeShow.new(nil, nominal_args)
    res = sut.line
    assert_equal(
      {"aids"=>[
        {"id"=>146, 
          "name"=>"Près de chez vous : Sphère Emploi Tarbes Pyrénées", 
          "ordre_affichage"=>1, 
          "short_description"=>"Communauté d'entraide réservée aux personnes qui exercent une activité à temps partiel", 
          "slug"=>"pres-de-chez-vous-sphere-emploi-tarbes-pyrenees"}, 
          {"id"=>60, 
            "name"=>"Accompagnement Intensif des Jeunes (AIJ)", 
            "ordre_affichage"=>46, 
            "short_description"=>"Accompagnement spécifique pour le public jeune afin d'accélérer et sécuriser le retour à l'emploi", 
            "slug"=>"accompagnement-intensif-des-jeunes-aij"}
        ], 
        "contract_type_id"=>6, 
        "description"=>nil, 
        "icon"=>nil, 
        "order"=>nil, 
        "unfold"=>{"value"=>false}
      }, 
      res
    )
  end


  def nominal_args
    {
      :contract=>
        {"id"=>6, "name"=>"Appui à l'embauche", "slug"=>"appui-a-l-embauche"},
      :aids=>
      [   
        {"id"=>146,
          "name"=>"Près de chez vous : Sphère Emploi Tarbes Pyrénées",
          "slug"=>"pres-de-chez-vous-sphere-emploi-tarbes-pyrenees",
          "short_description"=>
           "Communauté d'entraide réservée aux personnes qui exercent une activité à temps partiel",
          "rule_id"=>274,
          "ordre_affichage"=>1,
          "contract_type_id"=>6,
          "filters"=>[{"id"=>12, "slug"=>"pres_de_chez_vous"}],
        },
       {"id"=>60,
          "name"=>"Accompagnement Intensif des Jeunes (AIJ)",
          "slug"=>"accompagnement-intensif-des-jeunes-aij",
          "short_description"=>
           "Accompagnement spécifique pour le public jeune afin d'accélérer et sécuriser le retour à l'emploi",
          "rule_id"=>123,
          "ordre_affichage"=>46,
          "contract_type_id"=>6,
          "filters"=>[{"id"=>4, "slug"=>"accompagne-recherche-emploi"}],
        },
      ]
    }

  end
end
