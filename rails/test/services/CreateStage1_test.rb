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

  test ".call, existing aid, sucessful save" do
    #given
    slug = 'fake_aid'
    _create_saved_aid_with_name(slug)
    #when
    is_successfully_saved, aid, notice_msg = CreateStage1.new.call(slug, _new_attributes)
    #then
    assert_equal(true, is_successfully_saved)
    assert_not_nil aid.id
    assert_nil aid.archived_at
    assert_equal('Les modifications ont bien été enregistrées.', notice_msg)
  end


  def _create_saved_aid_with_name(the_name)
    c = ContractType.new(name: the_name, ordre_affichage: 21).tap(&:save!)
    Aid.new("name"=>"fake_aid", 
        "what"=>"<p>https://example3.com</p><p>https://example4.com</p>\r\n", 
        "additionnal_conditions"=>"<p>conditions</p>\r\n", 
        "how_much"=>"<p>contenu</p>\r\n", 
        "how_and_when"=>"<p>comment</p>\r\n", 
        "limitations"=>"<p>infos</p>\r\n",
        "ordre_affichage" => 12,
        "contract_type" => c).tap(&:save!)
  end
  def _create_unsaved_aid_with_name(the_name)
    c = ContractType.new(name: the_name, ordre_affichage: 21).tap(&:save!)
    Aid.new("name"=>"fake_aid", 
        "what"=>"<p>https://example3.com</p><p>https://example4.com</p>\r\n", 
        "additionnal_conditions"=>"<p>conditions</p>\r\n", 
        "how_much"=>"<p>contenu</p>\r\n", 
        "how_and_when"=>"<p>comment</p>\r\n", 
        "limitations"=>"<p>infos</p>\r\n",
        "ordre_affichage" => 12,
        "contract_type" => c)
  end

  def _new_attributes
    {
      "what"=>"new_what", 
      "additionnal_conditions"=>"new_conditions"
    }
  end


end

