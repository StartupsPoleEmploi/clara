require 'test_helper'

class AdminPageTest < ActionDispatch::IntegrationTest
  
  test "Un superadmin peut lire l'heure Clara" do
    #given
    connect_as_superadmin
    #when
    get admin_get_clock_path
    #then
    assert_response :ok
    assert_select '.actual-delta', '0'
  end
  test "Un superadmin peut changer l'heure Clara" do
    #given
    connect_as_superadmin
    c = Clockdiff.create!(value: 0)
    #when
    post admin_post_clock_path, params: {"clock_delta"=>"2"}
    #then
    assert_response :ok
    assert_select '.actual-delta', '2'
  end

  test "Un superadmin peut demander à activer ou non peconnect" do
    #given
    connect_as_superadmin
    #when
    get admin_get_switch_peconnect_path
    #then
    assert_response :ok
  end
  test "Un superadmin peut activer ou non peconnect" do
    #given
    connect_as_superadmin
    expect_any_instance_of(PeconnectActivation).to receive(:switch_value)
    #when
    post admin_post_switch_peconnect_path
    #then
    assert_response :found
  end

  test "Un superadmin peut demander à changer les ZRR" do
    #given
    connect_as_superadmin
    #when
    get admin_get_zrr_path
    #then
    assert_response :ok
  end
  test "Un superadmin peut changer les ZRR" do
    #given
    connect_as_superadmin
    #when
    post admin_post_zrr_path, params: {csv_data: '02004,55082'}
    #then
    assert_response :ok
    assert_equal '02004,55082', Zrr.first.value
  end

  test "Un superadmin peut demander à vider le cache" do
    #given
    connect_as_superadmin
    #when
    get admin_get_cache_path
    #then
    assert_response :ok
  end
  test "Un superadmin peut vider le cache" do
    #given
    connect_as_superadmin
    expect_any_instance_of(ExpireCache).to receive(:call)
    #when
    post admin_post_cache_path, params: {}
    #then
    assert_response :ok
  end

  test "Un superadmin peut demander à charger les données de références" do
    #given
    connect_as_superadmin
    #when
    get admin_get_ref_data_path
    #then
    assert_response :ok
  end
  test "Un superadmin peut charger les données de références" do
    #given
    connect_as_superadmin
    expect(Rails.application).to receive(:load_seed)
    #when
    post admin_post_ref_data_path, params: {}
    #then
    assert_response :ok
  end

  test "Un superadmin peut demander à supprimer toutes les traces" do
    #given
    connect_as_superadmin
    #when
    get admin_get_delete_trace_path
    #then
    assert_response :ok
  end
  test "Un superadmin peut supprimer toutes les traces" do
    #given
    connect_as_superadmin
    expect(Trace).to receive(:destroy_all)
    #when
    post admin_post_delete_trace_path, params: {}
    #then
    assert_response :ok
  end

  test "Un superadmin peut demander à transférer qqch" do
    #given
    connect_as_superadmin
    #when
    get admin_get_transfer_descr_path
    #then
    assert_response :ok
  end
  test "Un superadmin peut transférer qqch" do
    #given
    connect_as_superadmin
    #when
    post admin_post_transfer_descr_path, params: {}
    #then
    assert_response :ok
  end

  def connect_as_superadmin
    u = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: u.email, password: u.password }}
  end

end
