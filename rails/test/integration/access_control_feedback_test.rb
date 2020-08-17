require 'test_helper'

class AccessControlFeedbackTest < ActionDispatch::IntegrationTest
  
  ########################################################
  ############               LIST           ##############
  ########################################################
  test "Un superadmin peut lister les feedbacks" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_feedbacks_path
    #then
    assert_response :ok
  end

  test "Un relecteur ne peut pas lister les feedbacks" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    #when
    get admin_feedbacks_path
    #then
    assert_response :ok
  end
  
  test "Un contributeur peut lister les feedbacks" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #when
    get admin_feedbacks_path
    #then
    assert_response :ok
  end
  

  ########################################################
  ############               READ           ##############
  ########################################################
  test "Un superadmin peut lire un feedback" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    feedback = Feedback.create!(content: "any")
    #when
    get admin_feedback_path(feedback.id)
    #then
    assert_response :ok
  end
  
  test "Un relecteur peut lire un feedback" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    feedback = Feedback.create!(content: "any")
    #when
    get admin_feedback_path(feedback.id)
    #then
    assert_response :ok
  end

  test "Un contributeur peut lire un feedback" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    feedback = Feedback.create!(content: "any")
    #when
    get admin_feedback_path(feedback.id)
    #then
    assert_response :ok
  end  
  
  ########################################################
  ############               EDIT             ############
  ########################################################
  test "Un superadmin ne peut pas accéder à l'édition d'un feedback" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    feedback = Feedback.create!(content: "any")
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_feedback_path(feedback.id)
    end
  end

  test "Un relecteur ne peut pas accéder à l'édition d'un feedback" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    feedback = Feedback.create!(content: "any")
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_feedback_path(feedback.id)
    end
  end

  test "Un contributeur ne peut pas accéder à l'édition d'un feedback" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    feedback = Feedback.create!(content: "any")
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_feedback_path(feedback.id)
    end
  end
  

  
  ########################################################
  ############               UPDATE             ##########
  ########################################################
  test "Un superadmin ne peut pas éditer un feedback" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    feedback = Feedback.create!(content: "any")
    #then
    assert_raises SecurityError do
      #when
      put admin_feedback_path(feedback.id, params: { feedback: { feedback_kind: "string" }})
    end
  end

  test "Un relecteur ne peut pas éditer un feedback" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    feedback = Feedback.create!(content: "any")
    #then
    assert_raises SecurityError do
      #when
      put admin_feedback_path(feedback.id, params: { feedback: { feedback_kind: "string" }})
    end
  end

  test "Un contributeur ne peut pas éditer un feedback" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    feedback = Feedback.create!(content: "any")
    #then
    assert_raises SecurityError do
      #when
      put admin_feedback_path(feedback.id, params: { feedback: { feedback_kind: "string" }})
    end
  end

  ########################################################
  ############               DELETE             ##########
  ########################################################
  test "Un superadmin peut supprimer un feedback" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    feedback = Feedback.create!(content: "any")
    assert_equal 1, Feedback.count
    #when
    delete admin_feedback_path(feedback.id)
    #then
    assert_response :found
    assert_equal 0, Feedback.count
  end

  test "Un relecteur ne peut pas supprimer un feedback" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    feedback = Feedback.create!(content: "any")
    #then
    assert_raises SecurityError do
      #when
      delete admin_feedback_path(feedback.id)
    end
  end

  test "Un contributeur ne peut pas supprimer un feedback" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    feedback = Feedback.create!(content: "any")
    #then
    assert_raises SecurityError do
      #when
      delete admin_feedback_path(feedback.id)
    end
  end

end
