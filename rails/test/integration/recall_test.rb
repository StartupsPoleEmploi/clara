require 'test_helper'

class RecallTest < ActionDispatch::IntegrationTest

  test "missing params, error are displayed" do
    #given
    connect_as_superadmin
    recall_params = {
      aid_id: "",
      trigger_at: "14/09/2021",
      hourmin: "07:30",
      email: "bdavidxyz@gmail.com"
    }

    #when
    post admin_recalls_path, params: {recall: recall_params}

    #then
    assert_response :success
    assert_select '.flash-error', {count: 1, text: 'Aide : doit être renseigné(e)'}
  end

  test "nominal scenario" do
    #given
    Clockdiff.create(value: 0)
    aid = _create_realistic_aid
    connect_as_superadmin
    recall_params = {
      aid_id: aid.id,
      trigger_at: "14/09/2021",
      hourmin: "07:30",
      email: "bdavidxyz@gmail.com"
    }
    job = double
    expect(SendRecallJob).to receive(:set).and_return(job)
    expect(job).to receive(:perform_later).with(instance_of(Integer), "http://www.example.com#{admin_recalls_path}")

    #when
    post admin_recalls_path, params: {recall: recall_params}

    #then
    last_recall_id = Recall.last.id
    assert_redirected_to(admin_recall_path(last_recall_id) + '?locale=fr')
  end

  def _create_realistic_aid
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    rule = Rule.create!({name: "r_majorite", value_eligible: "18", variable: variable_age, description: "descr", kind: "simple", operator_kind: "more_than"})
    aid = Aid.create!(name: "aaa", contract_type: contract, rule: rule, ordre_affichage: 3, what: 'x', how_and_when: 'y', how_much: 'z')
  end

end
