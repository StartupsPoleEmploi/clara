require 'test_helper'

class AccessPeidTest < ActionDispatch::IntegrationTest

  ########################################################
  ############               CREATE         ##############
  ########################################################
  test "Un superadmin ne peut pas créer un peid" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    count_before = Peid.count
    #then
    assert_raises ActionController::RoutingError do
      #when
      post admin_peids_path, params: { peid: {value: 'v'}}
    end
    assert_equal count_before, Peid.count
  end

  test "Un relecteur ne peut pas créer un peid" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    count_before = Peid.count
    #then
    assert_raises ActionController::RoutingError do
      #when
      post admin_peids_path, params: { peid: {value: 'v'}}
    end
    assert_equal count_before, Peid.count
  end

  test "Un contributeur ne peut pas créer un peid" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    count_before = Peid.count
    #then
    assert_raises ActionController::RoutingError do
      #when
      post admin_peids_path, params: { peid: {value: 'v'}}
    end
    assert_equal count_before, Peid.count
  end

  ########################################################
  ############               LIST           ##############
  ########################################################
  test "Un superadmin peut lister les peids" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_peids_path
    #then
    assert_response :ok
  end

  test "Un relecteur ne peut pas lister les peids" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    assert_raises SecurityError do
      #when
      get admin_peids_path
    end
  end
  
  test "Un contributeur ne peut pas lister les peids" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    assert_raises SecurityError do
      #when
      get admin_peids_path
    end
  end


  ########################################################
  ############               READ           ##############
  ########################################################
  test "Un superadmin ne peut pas lire un peid" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    peid = Peid.create!(value: 'v')
    #then
    assert_raises NoMethodError do
      #when
      get admin_peid_path(peid.id)
    end
  end
  
  test "Un relecteur ne peut pas lire un peid" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    peid = Peid.create!(value: 'v')
    #then
    assert_raises NoMethodError do
      #when
      get admin_peid_path(peid.id)
    end
  end

  test "Un contributeur ne peut pas lire un peid" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    peid = Peid.create!(value: 'v')
    #then
    assert_raises NoMethodError do
      #when
      get admin_peid_path(peid.id)
    end
  end  
  
  ########################################################
  ############               EDIT             ############
  ########################################################
  test "Un superadmin peut accéder à l'édition d'un peid" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    peid = Peid.create!(value: 'v')
    #then
    assert_raises NoMethodError do
      #when
      get edit_admin_peid_path(peid.id)
    end
  end

  test "Un relecteur ne peut pas accéder à l'édition d'un peid" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    peid = Peid.create!(value: 'v')
    #then
    assert_raises NoMethodError do
      #when
      get admin_peid_path(peid.id)
    end
  end

  test "Un contributeur ne peut pas accéder à l'édition d'un peid" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    peid = Peid.create!(value: 'v')
    #then
    assert_raises NoMethodError do
      #when
      get edit_admin_peid_path(peid.id)
    end
  end
  

  
  ########################################################
  ############               UPDATE             ##########
  ########################################################
  test "Un superadmin peut éditer un peid" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    peid = Peid.create!(value: 'v')
    #then
    assert_raises NoMethodError do
      #when
      put admin_peid_path(peid.id)
    end
  end

  test "Un relecteur ne peut pas éditer un peid" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    peid = Peid.create!(value: 'v')
    #then
    assert_raises NoMethodError do
      #when
      put admin_peid_path(peid.id)
    end
  end

  test "Un contributeur ne peut pas éditer un peid" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    peid = Peid.create!(value: 'v')
    #then
    assert_raises NoMethodError do
      #when
      put admin_peid_path(peid.id)
    end
  end

  ########################################################
  ############               DELETE             ##########
  ########################################################
  test "Un superadmin peut supprimer un peid" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    peid = Peid.create!(value: 'v')
    count_before = Peid.count
    #then
    assert_raises NoMethodError do
      #when
      delete admin_peid_path(peid.id)
    end
    assert_equal count_before, Peid.count
  end

  test "Un relecteur ne peut pas supprimer un peid" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    peid = Peid.create!(value: 'v')
    count_before = Peid.count
    #then
    assert_raises NoMethodError do
      #when
      delete admin_peid_path(peid.id)
    end
    assert_equal count_before, Peid.count
  end

  test "Un contributeur ne peut pas supprimer un peid" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    peid = Peid.create!(value: 'v')
    count_before = Peid.count
    #then
    assert_raises NoMethodError do
      #when
      delete admin_peid_path(peid.id)
    end
    assert_equal count_before, Peid.count
  end

end
