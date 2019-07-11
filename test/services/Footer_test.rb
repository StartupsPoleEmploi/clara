require "test_helper"

class FooterTest < ActiveSupport::TestCase
  
  test ".first_part_of_contract_type returns half of the given contract_types" do
    allow(JsonModelsService).to receive(:contracts).and_return(contracts)
    res = Footer.new(nil, nil)
    assert_equal("blabla", res.first_part_of_contract_type)
  end

  def contracts
    [
      {"name" => "Emploi international", "id" => 3,  "slug" => "emploi-international"}
      {"name" => "Contrat spécifique",   "id" => 5,  "slug" => "contrat-specifique"}
      {"name" => "Dispositif séniors",   "id" => 9,  "slug" => "dispositif-seniors"}
      {"name" => "Contrat en alternance", "id" => 7,  "slug" => "contrat-en-alternance"}
      {"name" => "Aide régionale", "id" => 10,  "slug" => "aide-regionale"}
    ]
  end

end
