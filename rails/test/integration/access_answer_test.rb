require 'test_helper'

class AccessAnswerTest < ActionDispatch::IntegrationTest
  
  ########################################################
  ############               LIST           ##############
  ########################################################
  test "Un superadmin peut lister les answers" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_answers_path
    #then
    assert_response :ok
  end

  test "Un relecteur peut lister les answers" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    #when
    get admin_answers_path
    #then
    assert_response :ok
  end

  test "Un contributeur peut lister les answers" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #when
    get admin_answers_path
    #then
    assert_response :ok
  end


  ########################################################
  ############               READ           ##############
  ########################################################
  test "Un superadmin peut lire une answer" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    a_answer = Answer.create!(age: "42")
    #when
    get admin_answer_path(a_answer.id)
    #then
    assert_response :ok
  end
  
  test "Un relecteur peut lire une answer" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    a_answer = Answer.create!(age: "42")
    #when
    get admin_answer_path(a_answer.id)
    #then
    assert_response :ok
  end

  test "Un contributeur peut lire une answer" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    a_answer = Answer.create!(age: "42")
    #when
    get admin_answer_path(a_answer.id)
    #then
    assert_response :ok
  end
  
  
  ########################################################
  ############               EDIT             ############
  ########################################################
  test "Un superadmin ne peut pas accéder à l'édition d'une answer" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    a_answer = Answer.create!(age: "42")
    #then
    assert_raises NoMethodError do
      #when
      get edit_admin_answer_path(a_answer.id)
    end
  end

  test "Un relecteur ne peut pas accéder à l'édition d'une answer" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    a_answer = Answer.create!(age: "42")
    #then
    assert_raises NoMethodError do
      #when
      get edit_admin_answer_path(a_answer.id)
    end
  end

  test "Un contributeur ne peut pas accéder à l'édition d'une answer" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    a_answer = Answer.create!(age: "42")
    #then
    assert_raises NoMethodError do
      #when
      get edit_admin_answer_path(a_answer.id)
    end
  end
  
  
  ########################################################
  ############               UPDATE             ##########
  ########################################################
  test "Un superadmin ne peut pas éditer une answer" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    a_answer = Answer.create!(age: "42")
    #then
    assert_raises ActionController::RoutingError do
      #when
      put admin_answer_path(a_answer.id, params: { answer: { age: "43" }})
    end
  end

  test "Un relecteur ne peut pas éditer une answer" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    a_answer = Answer.create!(age: "42")
    #then
    assert_raises ActionController::RoutingError do
      #when
      put admin_answer_path(a_answer.id, params: { answer: { age: "43" }})
    end
  end

  test "Un contributeur ne peut pas éditer une answer" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    a_answer = Answer.create!(age: "42")
    #then
    assert_raises ActionController::RoutingError do
      #when
      put admin_answer_path(a_answer.id, params: { answer: { age: "43" }})
    end
  end

  ########################################################
  ############               DELETE             ##########
  ########################################################
  test "Un superadmin peut supprimer une answer" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    a_answer = Answer.create!(age: "42")
    assert_equal 1, Answer.count
    #when
    delete admin_answer_path(a_answer.id)
    #then
    assert_response :found
    assert_equal 0, Answer.count
  end

  test "Un relecteur ne peut pas supprimer une answer" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    a_answer = Answer.create!(age: "42")
    #then
    assert_raises SecurityError do
      #when
      delete admin_answer_path(a_answer.id)
    end
  end

  test "Un contributeur ne peut pas supprimer une answer" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    a_answer = Answer.create!(age: "42")
    #then
    assert_raises SecurityError do
      #when
      delete admin_answer_path(a_answer.id)
    end
  end

end
