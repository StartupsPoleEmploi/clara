require "test_helper"

class FooterTest < ActiveSupport::TestCase
  
  test ".call, returns nil if not found" do
    res = SendRecall.new.call(nil, nil)
    assert_equal(nil, res)
  end

  test ".call, nominal" do
    #given
    aid = _build_aid
    fake_mailer = OpenStruct.new(recall_email: OpenStruct.new(deliver_now: 'delivered_correctly'))
    recall = Recall.new(aid: aid, trigger_at: DateTime.new(2020, 8, 29, 12, 34, 56), hourmin: '09:38', email: 'myemail@example.com')
    recall.save!
    #expectations
    allow(RecallMailer).to receive(:with).and_return(fake_mailer)

    #when
    res = SendRecall.new.call(recall.id, 'https://myexample.com/')

    #then
    expect(RecallMailer).to have_received(:with).with(
      {
        :aid_link=> "myexample.com/admin/aid_creation/new_aid_stage_1?modify=true&slug=a_fake",
        :aid_name=>"a_fake",
        :aid_status=>"Publiée",
        :email_target=>"myemail@example.com"
      }
    )
    assert_equal('delivered_correctly', res)
  end

  def _build_aid
    #given
    c = ContractType.new(name: 'c_fake', ordre_affichage: 42)
    c.save
    v = Variable.new(name: 'v_fake', variable_kind: "string")
    v.save
    r1 = Rule.new(name: "r_fake", kind: "simple", variable: v, operator_kind: "more_than", description: "age...", value_eligible: "42")
    r1.save 
    r2 = Rule.new(
        name: "r_akfejtcdsvxmyblu_region_starts_with_bretagne_id_48035229939258206",
        value_eligible: "Bretag",
        variable: v,
        description: "Résider dans la région Bretagne",
        kind: "simple",
        operator_kind: "starts_with",
    )
    r2.save 
    r_root = Rule.new(
       name: "r_akfejtcdsvxmyblu_box_all",
       value_eligible: nil,
       composition_type: "and_rule",
       kind: "composite",
       slave_rules: [r1, r2]
    )
    r_root.save 
    aid = Aid.new(name: 'a_fake', ordre_affichage: 43, contract_type: c, rule: r_root, status: 'Publiée')
    aid.save
    # returns and aid with an ID
    aid
  end

end
