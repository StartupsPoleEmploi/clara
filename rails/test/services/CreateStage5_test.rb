require "test_helper"
    
class CreateStage5Test < ActiveSupport::TestCase

  test ".call, nominal" do
    #given
    slug = 'fake_aid'
    _create_aid_with_name(slug)
    action_asked = 'archive'
    #when
    res = CreateStage5.new.call(slug, action_asked)
    #then
    assert_equal("L'aide a bien été archivée, elle n'apparaîtra plus sur le site d'ici quelques secondes.", res)
    aid = Aid.find_by(slug: slug)
    assert_not_nil aid.archived_at
  end

  def _create_aid_with_name(the_name)
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

end

