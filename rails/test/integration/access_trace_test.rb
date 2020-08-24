require 'test_helper'

class AccessTraceTest < ActionDispatch::IntegrationTest
  
  ########################################################
  ############               LIST           ##############
  ########################################################
  test "Un superadmin peut lister les traces" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_traces_path
    #then
    assert_response :ok
  end
  
  test "Un relecteur ne peut pas lister les traces" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_traces_path
    end
  end

  test "Un contributeur ne peut pas lister les traces" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_traces_path
    end
  end
  

  ########################################################
  ############               READ           ##############
  ########################################################
  test "Un superadmin peut lire une trace" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    a_trace = Trace.create!(geo: "geo")
    #when
    get admin_trace_path(a_trace.id)
    #then
    assert_response :ok
  end
  
  test "Un relecteur ne peut pas lire une trace" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    a_trace = Trace.create!(geo: "geo")
    #then
    assert_raises SecurityError do
      #when
      get admin_trace_path(a_trace.id)
    end
  end

  test "Un contributeur ne peut pas lire une trace" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    a_trace = Trace.create!(geo: "geo")
    #then
    assert_raises SecurityError do
      #when
      get admin_trace_path(a_trace.id)
    end
  end
  
  
  ########################################################
  ############               EDIT             ############
  ########################################################
  test "Un superadmin peut accéder à l'édition d'une trace" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    a_trace = Trace.create!(geo: "geo")
    #when
    get edit_admin_trace_path(a_trace.id)
    #then
    assert_response :ok
  end

  test "Un relecteur ne peut pas accéder à l'édition d'une trace" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    a_trace = Trace.create!(geo: "geo")
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_trace_path(a_trace.id)
    end
  end

  test "Un contributeur ne peut pas accéder à l'édition d'une trace" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    a_trace = Trace.create!(geo: "geo")
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_trace_path(a_trace.id)
    end
  end
  
  
  ########################################################
  ############               UPDATE             ##########
  ########################################################
  test "Un superadmin peut éditer une trace" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    a_trace = Trace.create!(geo: "geo")
    #when
    put admin_trace_path(a_trace.id, params: { trace: { geo: "string" }})
    #then
    assert_response :found
    assert_equal "string", Trace.last.geo
  end

  test "Un relecteur ne peut pas éditer une trace" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    a_trace = Trace.create!(geo: "geo")
    #then
    assert_raises SecurityError do
      #when
      put admin_trace_path(a_trace.id, params: { trace: { geo: "string" }})
    end
  end

  test "Un contributeur ne peut pas éditer une trace" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    a_trace = Trace.create!(geo: "geo")
    #then
    assert_raises SecurityError do
      #when
      put admin_trace_path(a_trace.id, params: { trace: { geo: "string" }})
    end
  end

  ########################################################
  ############               DELETE             ##########
  ########################################################
  test "Un superadmin peut supprimer une trace" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    a_trace = Trace.create!(geo: "geo")
    assert_equal 1, Trace.count
    #when
    delete admin_trace_path(a_trace.id)
    #then
    assert_response :found
    assert_equal 0, Trace.count
  end

  test "Un relecteur ne peut pas supprimer une trace" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    a_trace = Trace.create!(geo: "geo")
    #then
    assert_raises SecurityError do
      #when
      delete admin_trace_path(a_trace.id)
    end
  end

  test "Un contributeur ne peut pas supprimer une trace" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    a_trace = Trace.create!(geo: "geo")
    #then
    assert_raises SecurityError do
      #when
      delete admin_trace_path(a_trace.id)
    end
  end

end
