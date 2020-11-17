require 'test_helper'

class AccessStage5Test < ActionDispatch::IntegrationTest

  test "Stage 5" do
    #given
    contributeur = User.create(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    filter = Filter.create!(name: "Se déplacer")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    aid = Aid.create!(name: "aaa", contract_type: contract, ordre_affichage: 3, filters: [filter])
    #when
    get admin_aid_creation_new_aid_stage_5_path
    #then
    assert_equal 'Toutes les informations obligatoires ont été saisies.', text_of('.is-expl-of-stage1').strip
  end

end
