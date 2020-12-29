require 'test_helper'

class AccessApiUserTest < ActionDispatch::IntegrationTest
  
  ########################################################
  ############               CREATE           ##############
  ########################################################
  test "Un superadmin peut créer un utilisateur de l'API" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    assert_equal 0, ApiUser.count
    #when
    post admin_api_users_path, params: { api_user: {email: 'one@e.com', password: 'z'}}
    #then
    assert_response :found
    assert_equal 1, ApiUser.count
  end

  test "Un relecteur peut créer un utilisateur de l'API" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    assert_equal 0, ApiUser.count
    #when
    post admin_api_users_path, params: { api_user: {email: 'one@e.com', password: 'z'}}
    #then
    assert_response :found
    assert_equal 1, ApiUser.count
  end

  test "Un contributeur ne peut pas créer un utilisateur de l'API" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    assert_equal 0, ApiUser.count
    #then
    assert_raises SecurityError do
      #when
      post admin_api_users_path, params: { api_user: {email: 'one@e.com', password: 'z'}}
    end
    assert_equal 0, ApiUser.count
  end

  ########################################################
  ############               LIST           ##############
  ########################################################
  test "Un superadmin peut lister les utilisateurs de l'API" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_api_users_path
    #then
    assert_response :ok
  end

  test "Un relecteur peut lister les utilisateurs de l'API" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    #when
    get admin_api_users_path
    #then
    assert_response :ok
  end
  
  test "Un contributeur ne peut pas lister les utilisateurs de l'API" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_api_users_path
    end
  end

  

  ########################################################
  ############               READ           ##############
  ########################################################
  test "Un superadmin peut lire un utilisateur de l'API" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    api_user = ApiUser.create!(email: "x@y.z", password: 'p')
    #when
    get admin_api_user_path(api_user.id)
    #then
    assert_response :ok
  end
  
  test "Un relecteur peut lire un utilisateur de l'API" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    api_user = ApiUser.create!(email: "x@y.z", password: 'p')
    #when
    get admin_api_user_path(api_user.id)
    #then
    assert_response :ok
  end

  test "Un contributeur ne peut pas lire un utilisateur de l'API" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    api_user = ApiUser.create!(email: "x@y.z", password: 'p')
    #then
    assert_raises SecurityError do
      #when
      get admin_api_user_path(api_user.id)
    end
  end  
  
  ########################################################
  ############               EDIT             ############
  ########################################################
  test "Un superadmin peut accéder à l'édition d'un utilisateur de l'API" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    api_user = ApiUser.create!(email: "x@y.z", password: 'p')
    #when
    get edit_admin_api_user_path(api_user.id)
    #then
    assert_response :ok
  end

  test "Un relecteur peut accéder à l'édition d'un utilisateur de l'API" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    api_user = ApiUser.create!(email: "x@y.z", password: 'p')
    #when
    get edit_admin_api_user_path(api_user.id)
    #then
    assert_response :ok
  end

  test "Un contributeur ne peut pas accéder à l'édition d'un utilisateur de l'API" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    api_user = ApiUser.create!(email: "x@y.z", password: 'p')
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_api_user_path(api_user.id)
    end
  end
  

  
  ########################################################
  ############               UPDATE             ##########
  ########################################################
  test "Un superadmin peut éditer un utilisateur de l'API" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    api_user = ApiUser.create!(email: "x@y.z", password: 'p')
    #when
    put admin_api_user_path(api_user.id, params: { api_user: {email: 'other@e.com'}})
    #then
    assert_response :found
    assert_equal "other@e.com", ApiUser.last.email
  end

  test "Un relecteur peut éditer un utilisateur de l'API" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    api_user = ApiUser.create!(email: "x@y.z", password: 'p')
    #when
    put admin_api_user_path(api_user.id, params: { api_user: {email: 'other@e.com'}})
    #then
    assert_response :found
    assert_equal "other@e.com", ApiUser.last.email
  end

  test "Un contributeur ne peut pas éditer un utilisateur de l'API" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    api_user = ApiUser.create!(email: "x@y.z", password: 'p')
    #then
    assert_raises SecurityError do
      #when
      put admin_api_user_path(api_user.id)
    end
  end

  ########################################################
  ############               DELETE             ##########
  ########################################################
  test "Un superadmin peut supprimer un utilisateur de l'API" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    api_user = ApiUser.create!(email: "x@y.z", password: 'p')
    assert_equal 1, ApiUser.count
    #when
    delete admin_api_user_path(api_user.id)
    #then
    assert_response :found
    assert_equal 0, ApiUser.count
  end

  test "Un relecteur peut supprimer un utilisateur de l'API" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    api_user = ApiUser.create!(email: "x@y.z", password: 'p')
    assert_equal 1, ApiUser.count
    #when
    delete admin_api_user_path(api_user.id)
    #then
    assert_response :found
    assert_equal 0, ApiUser.count
  end

  test "Un contributeur ne peut pas supprimer un utilisateur de l'API" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    api_user = ApiUser.create!(email: "x@y.z", password: 'p')
    #then
    assert_raises SecurityError do
      #when
      delete admin_api_user_path(api_user.id)
    end
  end

end
