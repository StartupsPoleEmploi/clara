require 'test_helper'

class AccessBackofficeTest < ActionDispatch::IntegrationTest

  test "L'accès au backoffice est interdit par défaut" do
    #given
    #when
    get admin_root_path
    #then
    assert_response :redirect
  end

  test "L'accès au backoffice est autorisé pour un contributeur" do
    #given
    contributeur = User.create(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #when
    get admin_root_path
    #then
    assert_response :ok
  end
  
  test "L'accès au backoffice est autorisé pour un relecteur" do
    #given
    relecteur = User.create(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    #when
    get admin_root_path
    #then
    assert_response :ok
  end
  
  test "L'accès au backoffice est autorisé pour un superadmin" do
    #given
    superadmin = User.create(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_root_path
    #then
    assert_response :ok
  end
  
end
