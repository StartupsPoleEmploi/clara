require 'test_helper'

class AccessConventionTest < ActionDispatch::IntegrationTest
  
  ########################################################
  ############               LIST           ##############
  ########################################################
  test "Un superadmin peut lister les conventions" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_conventions_path
    #then
    assert_response :ok
  end

  test "Un relecteur peut lister les conventions" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    #when
    get admin_conventions_path
    #then
    assert_response :ok
  end

  test "Un contributeur peut lister les conventions" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #when
    get admin_conventions_path
    #then
    assert_response :ok
  end


  ########################################################
  ############               READ           ##############
  ########################################################
  test "Un superadmin peut lire une convention" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    a_convention = Convention.create!(name: "one_convention")
    #when
    get admin_convention_path(a_convention.id)
    #then
    assert_response :ok
  end
  
  test "Un relecteur peut lire une convention" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    a_convention = Convention.create!(name: "one_convention")
    #when
    get admin_convention_path(a_convention.id)
    #then
    assert_response :ok
  end

  test "Un contributeur peut lire une convention" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    a_convention = Convention.create!(name: "one_convention")
    #when
    get admin_convention_path(a_convention.id)
    #then
    assert_response :ok
  end
  
  
  ########################################################
  ############               EDIT             ############
  ########################################################
  test "Un superadmin peut accéder à l'édition d'une convention" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    a_convention = Convention.create!(name: "one_convention")
    #when
    get edit_admin_convention_path(a_convention.id)
    #then
    assert_response :ok
  end

  test "Un relecteur peut accéder à l'édition d'une convention" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    a_convention = Convention.create!(name: "one_convention")
    #when
    get edit_admin_convention_path(a_convention.id)
    #then
    assert_response :ok
  end

  test "Un contributeur ne peut pas accéder à l'édition d'une convention" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    a_convention = Convention.create!(name: "one_convention")
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_convention_path(a_convention.id)
    end
  end
  
  
  ########################################################
  ############               UPDATE             ##########
  ########################################################
  test "Un superadmin peut éditer une convention" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    a_convention = Convention.create!(name: "one_convention")
    #when
    put admin_convention_path(a_convention.id, params: { convention: { name: "string" }})
    #then
    assert_response :found
    assert_equal "string", Convention.last.name
  end

  test "Un relecteur peut éditer une convention" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    a_convention = Convention.create!(name: "one_convention")
    #when
    put admin_convention_path(a_convention.id, params: { convention: { name: "string" }})
    #then
    assert_response :found
    assert_equal "string", Convention.last.name
  end

  test "Un contributeur ne peut pas éditer une convention" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    a_convention = Convention.create!(name: "one_convention")
    #then
    assert_raises SecurityError do
      #when
      put admin_convention_path(a_convention.id, params: { convention: { name: "string" }})
    end
  end

  ########################################################
  ############               DELETE             ##########
  ########################################################
  test "Un superadmin peut supprimer une convention" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    a_convention = Convention.create!(name: "one_convention")
    assert_equal 1, Convention.count
    #when
    delete admin_convention_path(a_convention.id)
    #then
    assert_response :found
    assert_equal 0, Convention.count
  end

  test "Un relecteur ne peut pas supprimer une convention" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    a_convention = Convention.create!(name: "one_convention")
    #then
    assert_raises SecurityError do
      #when
      delete admin_convention_path(a_convention.id)
    end
  end

  test "Un contributeur ne peut pas supprimer une convention" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    a_convention = Convention.create!(name: "one_convention")
    #then
    assert_raises SecurityError do
      #when
      delete admin_convention_path(a_convention.id)
    end
  end

end
