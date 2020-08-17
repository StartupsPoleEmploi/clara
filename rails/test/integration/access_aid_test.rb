require 'test_helper'

class AccessAidTest < ActionDispatch::IntegrationTest

  test "Un contributeur peut lister les aides" do
    #given
    contributeur = User.create(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #when
    get admin_aids_path
    #then
    assert_response :ok
  end
    
  test "Un contributeur peut créer une aide, étape 1" do
    #given
    contributeur = User.create(role: "contributeur", email:"a@b.c", password: "p")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #when
    post admin_aid_creation_create_stage_1_path, params: {
      "slug"=>{"value"=>""}, 
      "modify"=>{"value"=>""}, 
      "aid"=>{"name"=>"aaa", "contract_type_id"=>contract.id.to_s, "ordre_affichage"=>"42", "source"=>"myself"}
    }
    #then
    assert_response :redirect
    assert_redirected_to admin_aid_creation_new_aid_stage_2_path(locale: 'fr', slug: 'aaa', modify: '')
    assert 'aaa', Aid.last.name
  end
    
  test "Un contributeur peut créer une aide, étape 2" do
    #given
    contributeur = User.create(role: "contributeur", email:"a@b.c", password: "p")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    aid = Aid.create!(name: "aaa", contract_type: contract, ordre_affichage: 3)
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    # when 
    post admin_aid_creation_create_stage_2_path, params: {
      "aid"=>{
        "name"=>"aaa", 
        "what"=>"<p>descr</p>\r\n", 
        "additionnal_conditions"=>"<p>conditions</p>\r\n", 
        "how_much"=>"<p>contenu</p>\r\n", 
        "how_and_when"=>"<p>comment</p>\r\n", 
        "limitations"=>"<p>infos</p>\r\n"
      }, 
      "slug"=>{"value"=>"aaa"},
      "modify"=>{"value"=>""}, 
      "commit"=>"Enregistrer", 
      "locale"=>"fr"
    }
    #then
    assert_response :redirect
    assert_redirected_to admin_aid_creation_new_aid_stage_3_path(locale: 'fr', slug: 'aaa', modify: '')
    last_aid = Aid.last
    assert_equal "<p>descr</p>\r\n", last_aid.what
    assert_equal "<p>conditions</p>\r\n", last_aid.additionnal_conditions
    assert_equal "<p>contenu</p>\r\n", last_aid.how_much
    assert_equal "<p>comment</p>\r\n", last_aid.how_and_when
    assert_equal "<p>infos</p>\r\n", last_aid.limitations
  end

  test "Un contributeur peut créer une aide, étape 3" do
    #given
    contributeur = User.create(role: "contributeur", email:"a@b.c", password: "p")
    filter = Filter.create!(name: "Se déplacer")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    aid = Aid.create!(name: "aaa", contract_type: contract, ordre_affichage: 3)
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    # when 
    post admin_aid_creation_create_stage_3_path, params: {
      "aid"=> {
        "name"=>"aaa", 
        "short_description"=>"résumé", 
        "filter_ids"=>[filter.id.to_s]}, 
        "slug"=>{"value"=>"aaa"}, 
        "modify"=>{"value"=>""}, 
        "locale"=>"fr"
    }
    #then
    assert_response :redirect
    assert_redirected_to admin_aid_creation_new_aid_stage_4_path(locale: 'fr', slug: 'aaa', modify: '')
    last_aid = Aid.last
    assert_equal 'résumé', last_aid.short_description
    assert_equal 1, last_aid.filters.size
    assert_equal 'se-deplacer', last_aid.filters.first.slug
  end

  test "Un contributeur peut créer une aide, étape 4" do
    #given
    contributeur      = User.create(role: "contributeur", email:"a@b.c", password: "p")
    filter            = Filter.create!(name: "Se déplacer")
    contract          = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    variable_age      = Variable.create!(name: "age", variable_kind: "integer")
    variable_alloc    = Variable.create!(name: "allocation_value_min", variable_kind: "integer")
    variable_location = Variable.create!(name: "location_state", variable_kind: "string")
    aid               = Aid.create!(name: "aaa", contract_type: contract, ordre_affichage: 3)
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    # when 
    post admin_aid_creation_create_stage_4_path, params: {
      "aid"=>"aaa", 
      "trundle"=>"{\"name\":\"root_box\",\"subcombination\":\"OR\",\"subboxes\":[{\"name\":\"box_1597675281336\",\"subcombination\":\"AND\",\"subboxes\":[{\"name\":\"box_1597675721380b\",\"subcombination\":\"\",\"subboxes\":[],\"xval\":\"18\",\"xop\":\"more_than\",\"xvar\":\"v_age\",\"xtxt\":\"Avoir un âge strictement supérieur à 18 ans\",\"is_editing\":false},{\"name\":\"box_1597675721380a\",\"subcombination\":\"\",\"subboxes\":[],\"xval\":\"28\",\"xop\":\"less_than\",\"xvar\":\"v_age\",\"xtxt\":\"Avoir un âge strictement inférieur à 28 ans\",\"is_editing\":false}],\"xval\":\"\",\"xop\":\"\",\"xvar\":\"\",\"xtxt\":\"\",\"is_editing\":false},{\"name\":\"box_1597675679784\",\"subcombination\":\"\",\"subboxes\":[],\"xval\":\"30\",\"xop\":\"less_than\",\"xvar\":\"v_allocation_value_min\",\"xtxt\":\"Recevoir une allocation strictement inférieure à 30 euros net journalier\",\"is_editing\":false}]}", "modify"=>"", "geo"=>"{\"selection\":\"rien_sauf\",\"town\":[],\"department\":[],\"region\":[{\"BRE\":\"Bretagne\"},{\"COR\":\"Corse\"}]}", 
      "locale"=>"fr"}
    #then
    assert_response :ok
    root_rule = Aid.last.rule
    assert_equal 'composite', root_rule.kind
    assert_equal 'and_rule', root_rule.composition_type
    assert_equal 2, root_rule.slave_rules.size
  end

end
