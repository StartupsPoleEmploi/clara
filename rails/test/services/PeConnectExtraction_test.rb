require "test_helper"
    
class PeConnectExtractionTest < ActiveSupport::TestCase

  test ".call, not a fake connection" do
    #given
    session = {}
    fake = false
    tokens = {access_token: 'an_access_token', id_token: 'an_id_token'}
    expect_any_instance_of(PeConnectToken).to receive(:call).with('a_base_url', 'a_code').and_return(tokens)
    allow_any_instance_of(PeConnectService).to receive(:call) {|x, y| y.split('/').last}
    #when
    res = PeConnectExtraction.new.call(session, 'a_base_url', 'a_code', fake)
    #then
    assert_equal({:id_token=>"an_id_token"}, session)
    assert_equal({info: "userinfo", 
                  statut: "statut", 
                  birth: "etat-civil", 
                  formation: "formations", 
                  coord: "coordonnees", 
                  alloc: "indemnisation"}, res)
  end

end

