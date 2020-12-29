require 'test_helper'

class AccessTracingTest < ActionDispatch::IntegrationTest
  
  ########################################################
  ############               LIST           ##############
  ########################################################
  test "Un superadmin peut lister les tracings" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_tracings_path
    #then
    assert_response :ok
  end
  
  test "Un relecteur ne peut pas lister les tracings" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_tracings_path
    end
  end

  test "Un contributeur ne peut pas lister les tracings" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_tracings_path
    end
  end
  

  ########################################################
  ############               READ           ##############
  ########################################################
  test "Un superadmin peut lire une trace" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: local_rule)
    #when
    get admin_tracing_path(trace.id)
    #then
    assert_response :ok
  end
  
  test "Un relecteur ne peut pas lire une trace" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: local_rule)
    #then
    assert_raises SecurityError do
      #when
      get admin_tracing_path(trace.id)
    end
  end

  test "Un contributeur ne peut pas lire une trace" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: local_rule)
    #then
    assert_raises SecurityError do
      #when
      get admin_tracing_path(trace.id)
    end
  end
  
  
  ########################################################
  ############               EDIT             ############
  ########################################################
  test "Un superadmin peut accéder à l'édition d'une trace" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: local_rule)
    #when
    get edit_admin_tracing_path(trace.id)
    #then
    assert_response :ok
  end

  test "Un relecteur ne peut pas accéder à l'édition d'une trace" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: local_rule)
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_tracing_path(trace.id)
    end
  end

  test "Un contributeur ne peut pas accéder à l'édition d'une trace" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: local_rule)
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_tracing_path(trace.id)
    end
  end
  
  
  ########################################################
  ############               UPDATE             ##########
  ########################################################
  test "Un superadmin peut éditer une trace" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: local_rule)
    #when
    put admin_tracing_path(trace.id, params: { tracing: { description: 'descr2' }})
    #then
    assert_response :found
    assert_equal 'descr2', Tracing.last.description
  end
  
  test "Un relecteur ne peut pas éditer une trace" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: local_rule)
    #then
    assert_raises SecurityError do
      #when
      put admin_tracing_path(trace.id, params: { tracing: { description: 'descr2' }})
    end
  end

  test "Un contributeur ne peut pas éditer une trace" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: local_rule)
    #then
    assert_raises SecurityError do
      #when
      put admin_tracing_path(trace.id, params: { tracing: { description: 'descr2' }})
    end
  end

  ########################################################
  ############               DELETE             ##########
  ########################################################
  test "Un superadmin peut supprimer une trace" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: local_rule)
    assert_equal 1, Tracing.count
    #when
    delete admin_tracing_path(trace.id)
    #then
    assert_response :found
    assert_equal 0, Tracing.count
  end

  test "Un relecteur ne peut pas supprimer une trace" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: local_rule)
    #then
    assert_raises SecurityError do
      #when
      delete admin_tracing_path(trace.id)
    end
  end

  test "Un contributeur ne peut pas supprimer une trace" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: local_rule)
    #then
    assert_raises SecurityError do
      #when
      delete admin_tracing_path(trace.id)
    end
  end

  def local_rule
    age_variable = Variable.find_or_create_by(name: 'v_age') do |var|
      var.name = "v_age"                   
      var.variable_kind = "integer"
      var.name_translation = "âge"
      var.is_visible = true
    end

    rule_a = Rule.create!({
      name: "r_fdsjmtrzunylagqc_box_1607963018482",
      value_eligible: "18",
      variable_id: age_variable.id,
      description: "Avoir un âge strictement supérieur à 18 ans",
      kind: "simple",
      operator_kind: "more_than",
      simulated: ""
    })

    rule_a
  end

end
