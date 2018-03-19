require 'rails_helper'

feature ResultService do 

  describe 'convert_to_displayable_hash' do   
    context 'Nominal case' do
      it 'Should convert an ActiveRecord Object to hash, with ensured contract_type_order key' do

        create(:rule, :be_an_adult, name: 'the_rule_name')
        the_rule = Rule.last
        the_contract_type = create(:contract_type, :contract_type_1, name: 'contract_name', description: 'contract description', ordre_affichage: 42, icon:'nice_icon')
        create(:aid, name: 'aid_name', ordre_affichage: 4, rule: the_rule, contract_type: the_contract_type)
        aid = Aid.last

        result = ResultService.new.convert_to_displayable_hash([aid])

        expect(result[0].slice(
          "id", "contract_type_id", "contract_type_order", "contract_type_description", "name", "ordre_affichage", "contract_type_icon")
        ).to eq(
        {"id"=> aid.id, 
          "contract_type_id"=> the_contract_type.id,  
          "contract_type_order"=> 42, 
          "contract_type_icon"=> 'nice_icon', 
          "contract_type_description"=> 'contract description', 
          "name"=>"aid_name", 
          "ordre_affichage"=> 4  })

      end
    end
    context 'Worst case' do
      it 'Should return an empty array if nothing is given' do
        result = ResultService.new.convert_to_displayable_hash(nil)
        expect(result).to eq([])
      end
      it 'Should return an empty array if wrong type is given' do
        result = ResultService.new.convert_to_displayable_hash(Date.new)
        expect(result).to eq([])
      end
    end
  end

end

