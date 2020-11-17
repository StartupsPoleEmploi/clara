require 'test_helper'

class AccessFilterTest < ActionDispatch::IntegrationTest
  

  test "Un simple visiteur ne peut pas lister les filters" do
    get admin_filters_path
    assert_redirected_to sign_in_path(locale: 'fr')
  end
  test "Un simple visiteur ne peut pas lire un filter" do
    get admin_filter_path(1)
    assert_redirected_to sign_in_path(locale: 'fr')
  end
  test "Un simple visiteur ne peut pas éditer un filter" do
    get edit_admin_filter_path(1)
    assert_redirected_to sign_in_path(locale: 'fr')
  end
  test "Un simple visiteur ne peut pas modifier un filter" do
    put admin_filter_path(1)
    assert_redirected_to sign_in_path(locale: 'fr')
  end
  test "Un simple visiteur ne peut pas supprimer un filter" do
    delete admin_filter_path(1)
    assert_redirected_to sign_in_path(locale: 'fr')
  end
  
  test "Un superadmin peut lister les filters" do
    #given
    filter, superadmin = _filter_and_superadmin
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_filters_path
    #then
    assert_response :ok
    assert_select 'table[aria-labelledby="page-title"] tbody tr', count: 1
  end

  # Ok, creates a cloudinary bug in CircleCI
  # test "Un superadmin peut lire un filter" do
  #   #given
  #   filter, superadmin = _filter_and_superadmin
  #   post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
  #   #when
  #   get admin_filter_path(filter.id)
  #   #then
  #   assert_response :ok
  # end  

  test "Un superadmin peut accéder à l'édition d'un filter" do
    #given
    filter, superadmin = _filter_and_superadmin
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get edit_admin_filter_path(filter.id)
    #then
    assert_response :ok
  end

  test "Un superadmin peut modifier un filter" do
    #given
    filter, superadmin = _filter_and_superadmin
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    put admin_filter_path(filter.id), params: { filter: { trigger_at: DateTime.new }}
    #then
    assert_response :found
  end

  test "Un superadmin peut supprimer un filter" do
    #given
    filter, superadmin = _filter_and_superadmin
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    delete admin_filter_path(filter.id)
    #then
    assert_response :found
  end


  test "Un contributeur ne peut pas lister les filters" do
    #given
    filter, contributeur = _filter_and_contributeur
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_filters_path
    end
  end

  test "Un contributeur ne peut pas lire un filter" do
    #given
    filter, contributeur = _filter_and_contributeur
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_filter_path(filter.id)
    end
  end  

  test "Un contributeur ne peut pas accéder à l'édition d'un filter" do
    #given
    filter, contributeur = _filter_and_contributeur
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_filter_path(filter.id)
    end
  end

  test "Un contributeur ne peut pas modifier un filter" do
    #given
    filter, contributeur = _filter_and_contributeur
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #then
    assert_raises SecurityError do
      #when
      put admin_filter_path(filter.id), params: { filter: { trigger_at: DateTime.new }}
    end
  end

  test "Un contributeur ne peut pas supprimer un filter" do
    #given
    filter, contributeur = _filter_and_contributeur
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #then
    assert_raises SecurityError do
      #when
      delete admin_filter_path(filter.id)
    end
  end



  def _filter_and_superadmin
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    filter  = Filter.create!(name: "Se déplacer")
    [filter, superadmin]
  end

  def _filter_and_contributeur
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    filter  = Filter.create!(name: "Se déplacer")
    [filter, contributeur]
  end

end
