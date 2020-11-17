require 'test_helper'

class AccessRecallTest < ActionDispatch::IntegrationTest
  

  test "Un simple visiteur ne peut pas lister les recalls" do
    get admin_recalls_path
    assert_redirected_to sign_in_path(locale: 'fr')
  end
  test "Un simple visiteur ne peut pas lire un recall" do
    get admin_recall_path(1)
    assert_redirected_to sign_in_path(locale: 'fr')
  end
  test "Un simple visiteur ne peut pas éditer un recall" do
    get edit_admin_recall_path(1)
    assert_redirected_to sign_in_path(locale: 'fr')
  end
  test "Un simple visiteur ne peut pas modifier un recall" do
    put admin_recall_path(1)
    assert_redirected_to sign_in_path(locale: 'fr')
  end
  test "Un simple visiteur ne peut pas supprimer un recall" do
    delete admin_recall_path(1)
    assert_redirected_to sign_in_path(locale: 'fr')
  end
  
  test "Un contributeur peut lister les recalls" do
    #given
    contributeur, recall = _recall
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #when
    get admin_recalls_path
    #then
    assert_response :ok
    assert_select '.js-table-row', count: 1
  end

  test "Un contributeur peut lire un recall" do
    #given
    contributeur, recall = _recall
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #when
    get admin_recall_path(recall.id)
    #then
    assert_response :ok
  end  

  test "Un contributeur peut accéder à l'édition d'un recall" do
    #given
    contributeur, recall = _recall
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #when
    get edit_admin_recall_path(recall.id)
    #then
    assert_response :ok
  end

  test "Un contributeur peut modifier un recall" do
    #given
    contributeur, recall = _recall
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #when
    put admin_recall_path(recall.id), params: { recall: { trigger_at: DateTime.new }}
    #then
    assert_response :found
  end

  test "Un contributeur peut supprimer un recall" do
    #given
    contributeur, recall = _recall
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #when
    delete admin_recall_path(recall.id)
    #then
    assert_response :found
  end

  def _recall
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    aid = Aid.create!(name: "aaa", contract_type: contract, ordre_affichage: 3)
    recall = Recall.create!(email: 'a@b.c', aid: aid, trigger_at: DateTime.new, hourmin: '14:33')
    [contributeur, recall]
  end

end
