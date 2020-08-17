require 'test_helper'

class AccessVariableTest < ActionDispatch::IntegrationTest
  
  ########################################################
  ############               LIST           ##############
  ########################################################
  test "Un superadmin peut lister les variables" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_variables_path
    #then
    assert_response :ok
  end
  
  test "Un relecteur ne peut pas lister les variables" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_variables_path
    end
  end

  test "Un contributeur ne peut pas lister les variables" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_variables_path
    end
  end
  

  ########################################################
  ############               READ           ##############
  ########################################################
  test "Un superadmin peut lire une variable" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    #when
    get admin_variable_path(variable_age.id)
    #then
    assert_response :ok
  end
  
  test "Un relecteur ne peut pas lire une variable" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    #then
    assert_raises SecurityError do
      #when
      get admin_variable_path(variable_age.id)
    end
  end

  test "Un contributeur ne peut pas lire une variable" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    #then
    assert_raises SecurityError do
      #when
      get admin_variable_path(variable_age.id)
    end
  end
  
  
  ########################################################
  ############               EDIT             ############
  ########################################################
  test "Un superadmin peut accéder à l'édition d'une variable" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    #when
    get edit_admin_variable_path(variable_age.id)
    #then
    assert_response :ok
  end

  test "Un relecteur ne peut pas accéder à l'édition d'une variable" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_variable_path(variable_age.id)
    end
  end

  test "Un contributeur ne peut pas accéder à l'édition d'une variable" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_variable_path(variable_age.id)
    end
  end
  
  
  ########################################################
  ############               UPDATE             ##########
  ########################################################
  test "Un superadmin peut éditer une variable" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    #when
    put admin_variable_path(variable_age.id, params: { variable: { variable_kind: "string" }})
    #then
    assert_response :found
    assert_equal "string", Variable.last.variable_kind
  end

  test "Un relecteur ne peut pas éditer une variable" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    #then
    assert_raises SecurityError do
      #when
      put admin_variable_path(variable_age.id, params: { variable: { variable_kind: "string" }})
    end
  end

  test "Un contributeur ne peut pas éditer une variable" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    #then
    assert_raises SecurityError do
      #when
      put admin_variable_path(variable_age.id, params: { variable: { variable_kind: "string" }})
    end
  end

  ########################################################
  ############               DELETE             ##########
  ########################################################
  test "Un superadmin peut supprimer une variable" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    assert_equal 1, Variable.count
    #when
    delete admin_variable_path(variable_age.id)
    #then
    assert_response :found
    assert_equal 0, Variable.count
  end

  test "Un relecteur ne peut pas supprimer une variable" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    #then
    assert_raises SecurityError do
      #when
      delete admin_variable_path(variable_age.id)
    end
  end

  test "Un contributeur ne peut pas supprimer une variable" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    #then
    assert_raises SecurityError do
      #when
      delete admin_variable_path(variable_age.id)
    end
  end

end
