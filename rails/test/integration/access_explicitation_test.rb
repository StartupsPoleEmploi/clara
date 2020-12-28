require 'test_helper'

class AccessExplicitationTest < ActionDispatch::IntegrationTest
  
  def _variable
    Variable.new(name: "age", variable_kind: "integer").tap(&:save!)
  end

  ########################################################
  ############               CREATE         ##############
  ########################################################
  test "Un superadmin peut créer une explicitation" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    count_before = Explicitation.count
    #when
    post admin_explicitations_path, params: { explicitation: {name: 'n', template: 't', variable_id: _variable.id}}
    #then
    assert_response :found
    assert_equal count_before + 1, Explicitation.count
  end

  test "Un relecteur peut créer une explicitation" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    count_before = Explicitation.count
    #then
    assert_raises SecurityError do
      #when
      post admin_explicitations_path, params: { explicitation: {name: 'n', template: 't', variable_id: _variable.id}}
    end
    assert_equal count_before, Explicitation.count
  end

  test "Un contributeur ne peut pas créer une explicitation" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    count_before = Explicitation.count
    #then
    assert_raises SecurityError do
      #when
      post admin_explicitations_path, params: { explicitation: {name: 'n', template: 't', variable_id: _variable.id}}
    end
    assert_equal count_before, Explicitation.count
  end

  ########################################################
  ############               LIST           ##############
  ########################################################
  test "Un superadmin peut lister les explicitations" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_explicitations_path
    #then
    assert_response :ok
  end

  test "Un relecteur peut lister les explicitations" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    assert_raises SecurityError do
      #when
      get admin_explicitations_path
    end
  end
  
  test "Un contributeur ne peut pas lister les explicitations" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    assert_raises SecurityError do
      #when
      get admin_explicitations_path
    end
  end


  ########################################################
  ############               READ           ##############
  ########################################################
  test "Un superadmin peut lire une explicitation" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    explicitation = Explicitation.create!(name: 'n', template: 't', variable_id: _variable.id)
    #when
    get admin_explicitation_path(explicitation.slug)
    #then
    assert_response :ok
  end
  
  test "Un relecteur ne peut pas lire une explicitation" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    explicitation = Explicitation.create!(name: 'n', template: 't', variable_id: _variable.id)
    #then
    assert_raises SecurityError do
      #when
      get admin_explicitation_path(explicitation.slug)
    end
  end

  test "Un contributeur ne peut pas lire une explicitation" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    explicitation = Explicitation.create!(name: 'n', template: 't', variable_id: _variable.id)
    #then
    assert_raises SecurityError do
      #when
      get admin_explicitation_path(explicitation.slug)
    end
  end  
  
  ########################################################
  ############               EDIT             ############
  ########################################################
  test "Un superadmin peut accéder à l'édition d'une explicitation" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    explicitation = Explicitation.create!(name: 'n', template: 't', variable_id: _variable.id)
    #when
    get edit_admin_explicitation_path(explicitation.slug)
    #then
    assert_response :ok
  end

  test "Un relecteur ne peut pas accéder à l'édition d'une explicitation" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    explicitation = Explicitation.create!(name: 'n', template: 't', variable_id: _variable.id)
    #then
    assert_raises SecurityError do
      #when
      get admin_explicitation_path(explicitation.slug)
    end
  end

  test "Un contributeur ne peut pas accéder à l'édition d'une explicitation" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    explicitation = Explicitation.create!(name: 'n', template: 't', variable_id: _variable.id)
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_explicitation_path(explicitation.slug)
    end
  end
  

  
  ########################################################
  ############               UPDATE             ##########
  ########################################################
  test "Un superadmin peut éditer une explicitation" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    explicitation = Explicitation.create!(name: 'n', template: 't', variable_id: _variable.id)
    #when
    put admin_explicitation_path(explicitation.slug, params: { explicitation: {template: 'k'}})
    #then
    assert_response :found
    assert_equal 'k', Explicitation.last.template
  end

  test "Un relecteur ne peut pas éditer une explicitation" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    explicitation = Explicitation.create!(name: 'n', template: 't', variable_id: _variable.id)
    #then
    assert_raises SecurityError do
      #when
      put admin_explicitation_path(explicitation.slug)
    end
  end

  test "Un contributeur ne peut pas éditer une explicitation" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    explicitation = Explicitation.create!(name: 'n', template: 't', variable_id: _variable.id)
    #then
    assert_raises SecurityError do
      #when
      put admin_explicitation_path(explicitation.slug)
    end
  end

  ########################################################
  ############               DELETE             ##########
  ########################################################
  test "Un superadmin peut supprimer une explicitation" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    explicitation = Explicitation.create!(name: 'n', template: 't', variable_id: _variable.id)
    count_before = Explicitation.count
    #when
    delete admin_explicitation_path(explicitation.slug)
    #then
    assert_response :found
    assert_equal count_before - 1, Explicitation.count
  end

  test "Un relecteur ne peut pas supprimer une explicitation" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    explicitation = Explicitation.create!(name: 'n', template: 't', variable_id: _variable.id)
    count_before = Explicitation.count
    #then
    assert_raises SecurityError do
      #when
      delete admin_explicitation_path(explicitation.slug)
    end
    assert_equal count_before, Explicitation.count
  end

  test "Un contributeur ne peut pas supprimer une explicitation" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    explicitation = Explicitation.create!(name: 'n', template: 't', variable_id: _variable.id)
    count_before = Explicitation.count
    #then
    assert_raises SecurityError do
      #when
      delete admin_explicitation_path(explicitation.slug)
    end
    assert_equal count_before, Explicitation.count
  end

end
