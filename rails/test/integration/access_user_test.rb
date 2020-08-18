require 'test_helper'

class AccessUserTest < ActionDispatch::IntegrationTest
  
  ########################################################
  ############               LIST           ##############
  ########################################################
  test "Un superadmin peut lister les administrateurs" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_users_path
    #then
    assert_response :ok
  end
  
  test "Un relecteur peut lister les administrateurs" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    #when
    get admin_users_path
    #then
    assert_response :ok
  end

  test "Un contributeur ne peut pas lister les administrateurs" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_users_path
    end
  end
  

  ########################################################
  ############               READ           ##############
  ########################################################
  test "Un superadmin peut lire un administrateur" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    user = User.create!(role: "contributeur", email:"a@z.f", password: "t")
    #when
    get admin_user_path(user.id)
    #then
    assert_response :ok
  end
  
  test "Un relecteur peut lire un administrateur" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    user = User.create!(role: "contributeur", email:"a@z.f", password: "t")
    #when
    get admin_user_path(user.id)
    #then
    assert_response :ok
  end

  test "Un contributeur ne peut pas lire un administrateur" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    user = User.create!(role: "contributeur", email:"a@z.f", password: "t")
    #then
    assert_raises SecurityError do
      #when
      get admin_user_path(user.id)
    end
  end
  
  
  ########################################################
  ############               EDIT             ############
  ########################################################
  test "Un superadmin peut accéder à l'édition d'une administrateur" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    user = User.create!(role: "contributeur", email:"a@z.f", password: "t")
    #when
    get edit_admin_user_path(user.id)
    #then
    assert_response :ok
  end

  test "Un relecteur ne peut pas accéder à l'édition d'une administrateur" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    user = User.create!(role: "contributeur", email:"a@z.f", password: "t")
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_user_path(user.id)
    end
  end

  test "Un contributeur ne peut pas accéder à l'édition d'une administrateur" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    user = User.create!(role: "contributeur", email:"a@z.f", password: "t")
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_user_path(user.id)
    end
  end
  
  
  ########################################################
  ############               UPDATE             ##########
  ########################################################
  test "Un superadmin peut éditer une administrateur" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    user = User.create!(role: "contributeur", email:"a@z.f", password: "t")
    #when
    put admin_user_path(user.id, params: { user: { role: 'relecteur' }})
    #then
    assert_response :found
    assert_equal 'relecteur', User.last.role
  end
  
  test "Un relecteur ne peut pas éditer un administrateur" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    user = User.create!(role: "contributeur", email:"a@z.f", password: "t")
    #then
    assert_raises SecurityError do
      #when
      put admin_user_path(user.id, params: { user: { role: 'relecteur' }})
    end
  end

  test "Un contributeur ne peut pas éditer un administrateur" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    user = User.create!(role: "contributeur", email:"a@z.f", password: "t")
    #then
    assert_raises SecurityError do
      #when
      put admin_user_path(user.id, params: { user: { role: 'relecteur' }})
    end
  end

  ########################################################
  ############               DELETE             ##########
  ########################################################
  test "Un superadmin peut supprimer un administrateur" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    user = User.create!(role: "contributeur", email:"a@z.f", password: "t")
    assert_equal 2, User.count
    #when
    delete admin_user_path(user.id)
    #then
    assert_response :found
    assert_equal 1, User.count
  end

  test "Un relecteur ne peut pas supprimer un administrateur" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    user = User.create!(role: "contributeur", email:"a@z.f", password: "t")
    #then
    assert_raises SecurityError do
      #when
      delete admin_user_path(user.id)
    end
  end

  test "Un contributeur ne peut pas supprimer un administrateur" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    user = User.create!(role: "contributeur", email:"a@z.f", password: "t")
    #then
    assert_raises SecurityError do
      #when
      delete admin_user_path(user.id)
    end
  end

end
