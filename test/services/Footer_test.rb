require "test_helper"

class FooterTest < ActiveSupport::TestCase
  
  test ".first_part_of_contract_type returns first half of the given contract_types" do
    allow(JsonModelsService).to receive(:contracts).and_return(contracts)
    res = Footer.new(nil, nil)
    assert_equal(
      [contract_1, contract_2], 
      res.first_part_of_contract_type
    )
  end

  test ".second_part_of_contract_type returns last half of the given contract_types" do
    allow(JsonModelsService).to receive(:contracts).and_return(contracts)
    res = Footer.new(nil, nil)
    assert_equal(
      [contract_3, contract_4, contract_5], 
      res.second_part_of_contract_type
    )
  end

  def contracts
    [ contract_1, contract_2, contract_3, contract_4, contract_5]
  end

  def contract_1
    {"name" => "Emploi international", "id" => 3,  "slug" => "emploi-international"}
  end

  def contract_2
    {"name" => "Contrat spécifique",   "id" => 5,  "slug" => "contrat-specifique"}
  end

  def contract_3
    {"name" => "Dispositif séniors",   "id" => 9,  "slug" => "dispositif-seniors"}
  end

  def contract_4
    {"name" => "Contrat en alternance", "id" => 7,  "slug" => "contrat-en-alternance"}
  end

  def contract_5
    {"name" => "Aide régionale", "id" => 10,  "slug" => "aide-regionale"}
  end


end
