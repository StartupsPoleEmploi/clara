require 'test_helper'

class AccessControlVariableTest < ActionDispatch::IntegrationTest
  
  test "Un superadmin peut lister les variables" do
    #given
    superadmin = User.create(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_variables_path
    #then
    assert_response :ok
  end
  
  test "Un contributeur ne peut pas lister les variables" do
    #given
    contributeur = User.create(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_variables_path
    end
  end
  
  test "Un relecteur ne peut pas lister les variables" do
    #given
    relecteur = User.create(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_variables_path
    end
  end
  
  test "Un superadmin peut lire une variable" do
    #given
    superadmin = User.create(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    variable_age = Variable.create(name: "age", variable_kind: "integer")
    #when
    get admin_variable_path(variable_age.id)
    #then
    assert_response :ok
  end
  
  test "Un contributeur ne peut pas lire une variable" do
    #given
    contributeur = User.create(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    variable_age = Variable.create(name: "age", variable_kind: "integer")
    #then
    assert_raises SecurityError do
      #when
      get admin_variable_path(variable_age.id)
    end
  end
  
  test "Un relecteur ne peut pas lire une variable" do
    #given
    relecteur = User.create(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    variable_age = Variable.create(name: "age", variable_kind: "integer")
    #then
    assert_raises SecurityError do
      #when
      get admin_variable_path(variable_age.id)
    end
  end
  
  
end
