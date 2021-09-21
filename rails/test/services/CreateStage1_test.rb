require "test_helper"
    
class CreateStage1Test < ActiveSupport::TestCase

  test ".call, unexisting aid, unsucessful save" do
    #given
    slug = ''
    new_attributes = {}
    #when
    is_successfully_saved, aid, notice_msg = CreateStage1.new.call(slug, new_attributes)
    #then
    assert_equal(false, is_successfully_saved)
    assert_nil aid.id
    assert_equal('', notice_msg)
  end

  test ".call, uncompleted aid, but successful save" do
    #given
    slug = 'uncomplete_aid'
    _create_draft_with_name(slug)
    #when
    is_successfully_saved, aid, notice_msg = CreateStage1.new.call(slug, _new_attributes)
    #then
    assert_equal(true, is_successfully_saved)
    assert_not_nil aid.id
    assert_nil aid.archived_at
    assert_equal('Les modifications ont bien été enregistrées.', notice_msg)
  end

  test ".call, activated aid, sucessful save" do
    #given
    slug = 'activated_aid'
    _create_activated_aid_with_name(slug)
    #when
    is_successfully_saved, aid, notice_msg = CreateStage1.new.call(slug, _new_attributes)
    #then
    assert_equal(true, is_successfully_saved)
    assert_not_nil aid.id
    assert_nil aid.archived_at
    assert_equal('Les modifications vont être publiées sur le site web ! <br> Cela peut prendre quelques secondes.', notice_msg)
  end

  def _create_draft_with_name(the_name)
    c = ContractType.new(name: 'fake_contract', ordre_affichage: 21).tap(&:save!)
    Aid.new("name"=>the_name, "ordre_affichage" => 12, "contract_type" => c).tap(&:save!)
  end

  def _create_activated_aid_with_name(the_name)
    c = ContractType.new(name: the_name, ordre_affichage: 21).tap(&:save!)
    v = Variable.new(name: 'v_fake_age', variable_kind: "string")
    v.save
    r1 = Rule.new(name: "r_fake_age", kind: "simple", variable: v, operator_kind: "more_than", description: "age...", value_eligible: "42")
    r1.save 
    Aid.new("name"=>the_name, 
        "what"=>"<p>https://example3.com</p><p>https://example4.com</p>\r\n", 
        "additionnal_conditions"=>"<p>conditions</p>\r\n", 
        "how_much"=>"<p>contenu</p>\r\n", 
        "how_and_when"=>"<p>comment</p>\r\n", 
        "limitations"=>"<p>infos</p>\r\n",
        "ordre_affichage" => 12,
        "contract_type" => c,
        "rule" => r1).tap(&:save!)
  end


  def _new_attributes
    {
      "what"=>"new_what", 
      "additionnal_conditions"=>"new_conditions"
    }
  end


end

