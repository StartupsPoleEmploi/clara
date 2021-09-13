require "test_helper"
    
class PeConnectExtractionTest < ActiveSupport::TestCase

  test ".call, not a fake connection" do
    #given
    session = {}
    base_url = 'a_base_url'
    code = 'a_code'
    fake = false

    tokens = {access_token: 'an_access_token', id_token: 'an_id_token'}
    expect_any_instance_of(PeConnectToken).to receive(:call).with(base_url, code).and_return(tokens)

    pe_connect = double
    expect(PeConnectService).to receive(:new).and_return(pe_connect)
    # expect(pe_connect).to receive(:call).with(_user_info, 'a_valid_token').and_return('an_info')
    # expect(pe_connect).to receive(:call).with(_statut, 'a_valid_token').and_return('a_statut')
    # expect(pe_connect).to receive(:call).with(_birth, 'a_valid_token').and_return('a_birth')
    # expect(pe_connect).to receive(:call).with(_formation, 'a_valid_token').and_return('a_formation')
    # expect(pe_connect).to receive(:call).with(_coord, 'a_valid_token').and_return('a_coord')
    # expect(pe_connect).to receive(:call).with(_alloc, 'a_valid_token').and_return('an_alloc')

    #when
    res = PeConnectExtraction.new.call(session, base_url, code, fake)
    #then
    assert_equal('foo', res)
  end


  def _user_info
    'https://api.emploi-store.fr/partenaire/peconnect-individu/v1/userinfo'
  end

  def _statut
    'https://api.emploi-store.fr/partenaire/peconnect-statut/v1/statut'
  end

  def _birth
    'https://api.emploi-store.fr/partenaire/peconnect-datenaissance/v1/etat-civil'
  end

  def _formation
    'https://api.emploi-store.fr/partenaire/peconnect-formations/v1/formations'
  end

  def _coord
    'https://api.emploi-store.fr/partenaire/peconnect-coordonnees/v1/coordonnees'
  end

  def _alloc
    'https://api.emploi-store.fr/partenaire/peconnect-indemnisations/v1/indemnisation'
  end




end

