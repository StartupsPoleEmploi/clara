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
    
  test "Un contributeur peut créer une aide" do
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
    assert_redirected_to admin_aid_creation_new_aid_stage_2_path(locale: 'fr', slug: 'aaa', modify: '')
    assert_response :redirect
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
    assert_redirected_to admin_aid_creation_new_aid_stage_3_path(locale: 'fr', slug: 'aaa', modify: '')
    assert_response :redirect
    last_aid = Aid.last
    assert '<p>descr</p>', last_aid.what
    assert '<p>conditions</p>', last_aid.additionnal_conditions
    assert '<p>contenu</p>', last_aid.how_much
    assert '<p>comment</p>', last_aid.how_and_when
    assert '<p>infos</p>', last_aid.limitations
  end

end
